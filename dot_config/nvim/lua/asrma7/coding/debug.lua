local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

local function launchjs_type_to_filetypes()
	return {
		["pwa-node"] = js_filetypes,
		["pwa-chrome"] = js_filetypes,
		["node-terminal"] = js_filetypes,
		node = js_filetypes,
		chrome = js_filetypes,
		dart = { "dart" },
		flutter = { "dart" },
		python = { "python" },
		go = { "go" },
	}
end

local function get_args(config)
	local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
	local args_str = type(args) == "table" and table.concat(args, " ") or args

	config = vim.deepcopy(config)
	config.args = function()
		local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str))
		return require("dap.utils").splitstr(new_args)
	end
	return config
end

local function open_debug_ui()
	local ok, dapui = pcall(require, "dapui")
	if ok then
		dapui.open()
	end
end

local function terminate_debug()
	require("dap").terminate({
		on_done = function()
			local ok, dapui = pcall(require, "dapui")
			if ok then
				dapui.close()
			end
		end,
	})
end

local function strip_json_trailing_commas(str)
	local result = {}
	local i = 1
	local in_string = false
	local escaped = false

	while i <= #str do
		local char = str:sub(i, i)

		if in_string then
			table.insert(result, char)
			if escaped then
				escaped = false
			elseif char == "\\" then
				escaped = true
			elseif char == '"' then
				in_string = false
			end
		elseif char == '"' then
			in_string = true
			table.insert(result, char)
		elseif char == "," then
			local next_index = i + 1
			while next_index <= #str and str:sub(next_index, next_index):match("%s") do
				next_index = next_index + 1
			end

			local next_char = str:sub(next_index, next_index)
			if next_char ~= "}" and next_char ~= "]" then
				table.insert(result, char)
			end
		else
			table.insert(result, char)
		end

		i = i + 1
	end

	return table.concat(result)
end

local function configure_vscode_launch_json()
	local dap_vscode = require("dap.ext.vscode")
	local json = require("plenary.json")

	dap_vscode.json_decode = function(str)
		local without_comments = json.json_strip_comments(str, {})
		return vim.json.decode(strip_json_trailing_commas(without_comments))
	end
end

local function launchjs_path()
	return vim.fn.getcwd() .. "/.vscode/launch.json"
end

local function configure_launchjs_provider()
	local dap = require("dap")
	dap.providers.configs["asrma7.launch.json.compounds"] = nil
	dap.providers.configs["dap.launch.json"] = function(bufnr)
		local path = launchjs_path()
		local file = io.open(path, "r")
		if not file then
			return {}
		end

		local contents = file:read("*a")
		file:close()

		local ok, data = pcall(require("dap.ext.vscode").json_decode, contents)
		if not ok then
			return {}
		end

		local configurations = data.configurations or {}
		local compounds = data.compounds or {}
		local result = {}
		local seen = {}
		local configs_by_name = {}

		for _, config in ipairs(configurations) do
			if config.name then
				configs_by_name[config.name] = config
				if not seen[config.name] then
					seen[config.name] = true
					table.insert(result, config)
				end
			end
		end

		local type_to_filetypes = vim.tbl_extend("keep", launchjs_type_to_filetypes(), require("dap.ext.vscode").type_to_filetypes)
		local filetype = vim.b["dap-srcft"] or vim.bo[bufnr].filetype

		for _, compound in ipairs(compounds) do
			if compound.name and type(compound.configurations) == "table" then
				local child_configs = {}
				local applies_to_filetype = false

				for _, child_name in ipairs(compound.configurations) do
					local child = configs_by_name[child_name]
					if child then
						table.insert(child_configs, vim.deepcopy(child))
						if vim.tbl_contains(type_to_filetypes[child.type] or { child.type }, filetype) then
							applies_to_filetype = true
						end
					end
				end

				if applies_to_filetype and #child_configs > 0 and not seen[compound.name] then
					seen[compound.name] = true
					table.insert(result, setmetatable({
						name = compound.name,
						type = "compound",
						request = "launch",
					}, {
						__call = function()
							for _, child in ipairs(child_configs) do
								dap.run(vim.deepcopy(child), { new = true, filetype = filetype })
							end
							return { type = "compound", abort = dap.ABORT }
						end,
					}))
				end
			end
		end

		return result
	end
end

local function python_from_venv()
	local venv = vim.env.VIRTUAL_ENV
	if venv and venv ~= "" then
		if vim.fn.has("win32") == 1 then
			return venv .. "/Scripts/python.exe"
		end
		return venv .. "/bin/python"
	end

	return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or "python"
end

local function debugpy_python()
	local ok, registry = pcall(require, "mason-registry")
	if ok and registry.is_installed("debugpy") then
		local debugpy = registry.get_package("debugpy")
		local install_path = debugpy:get_install_path()
		local candidates = {
			install_path .. "/venv/bin/python",
			install_path .. "/venv/Scripts/python.exe",
		}

		for _, candidate in ipairs(candidates) do
			if vim.fn.executable(candidate) == 1 then
				return candidate
			end
		end
	end

	return python_from_venv()
end

local function configure_python(dap)
	dap.adapters.python = {
		type = "executable",
		command = debugpy_python(),
		args = { "-m", "debugpy.adapter" },
	}

	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Python: current file",
			program = "${file}",
			console = "integratedTerminal",
			pythonPath = python_from_venv,
		},
		{
			type = "python",
			request = "attach",
			name = "Python: attach localhost:5678",
			connect = {
				host = "127.0.0.1",
				port = 5678,
			},
			pythonPath = python_from_venv,
		},
	}
end

local function dart_project_root()
	local starts = {
		vim.fn.expand("%:p:h"),
		vim.fn.getcwd(),
	}

	for _, start in ipairs(starts) do
		if start and start ~= "" then
			local pubspec = vim.fs.find("pubspec.yaml", { path = start, upward = true, type = "file" })[1]
			if pubspec then
				return vim.fs.dirname(pubspec)
			end
		end
	end

	return vim.fn.getcwd()
end

local function dart_main()
	return dart_project_root() .. "/lib/main.dart"
end

local function select_flutter_device()
	local result = vim.system({ "flutter", "devices", "--machine" }, { text = true }):wait()
	if result.code ~= 0 then
		vim.notify(vim.trim(result.stderr or result.stdout or "Unable to list Flutter devices"), vim.log.levels.ERROR)
		return
	end

	local ok, devices = pcall(vim.json.decode, result.stdout)
	if not ok or type(devices) ~= "table" then
		vim.notify("Unable to parse Flutter devices", vim.log.levels.ERROR)
		return
	end

	if #devices == 0 then
		vim.notify("No Flutter devices found", vim.log.levels.WARN)
		return
	end

	vim.ui.select(devices, {
		prompt = "Flutter device",
		format_item = function(device)
			return string.format("%s (%s)", device.name or device.id, device.id)
		end,
	}, function(device)
		if not device then
			return
		end

		vim.g.asrma7_flutter_device_id = device.id
		vim.notify("Flutter device: " .. (device.name or device.id))
	end)
end

local function configure_dart(dap)
	dap.adapters.dart = {
		type = "executable",
		command = "dart",
		args = { "debug_adapter" },
	}

	dap.adapters.flutter = {
		type = "executable",
		command = "flutter",
		args = { "debug_adapter" },
	}

	dap.configurations.dart = {
		{
			name = "Dart: current file",
			type = "dart",
			request = "launch",
			program = "${file}",
			cwd = dart_project_root,
		},
		{
			name = "Flutter: launch",
			type = "flutter",
			request = "launch",
			program = dart_main,
			cwd = dart_project_root,
		},
	}

	vim.tbl_deep_extend("force", require("dap.ext.vscode").type_to_filetypes, {
		dart = { "dart" },
		flutter = { "dart" },
	})

	dap.listeners.on_config.asrma7_dart = function(config)
		if config.type ~= "dart" and config.type ~= "flutter" then
			return config
		end

		config = vim.deepcopy(config)
		if config.type == "dart" and config.flutterMode then
			config.type = "flutter"
		end
		if config.type == "flutter" and vim.g.asrma7_flutter_device_id and not config.deviceId then
			config.deviceId = vim.g.asrma7_flutter_device_id
		end
		return config
	end

	vim.api.nvim_create_user_command("FlutterDeviceSelect", select_flutter_device, {})

	for _, event in ipairs({
		"dart.debuggerUris",
		"flutter.appStart",
		"flutter.appStarted",
		"flutter.appStop",
	}) do
		dap.listeners.after["event_" .. event].asrma7_dart = function() end
	end
end

local function js_debug_server()
	return vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/dist/src/dapDebugServer.js")
end

local function build_js_debug(plugin)
	local function run(cmd)
		local result = vim.system(cmd, { cwd = plugin.dir, text = true }):wait()
		if result.code ~= 0 then
			error(table.concat({ result.stdout or "", result.stderr or "" }, "\n"))
		end
	end

	run({ "npm", "ci", "--ignore-scripts", "--loglevel=error" })
	run({ "npm", "run", "compile", "--", "dapDebugServer" })
end

local function js_project_root()
	local starts = {
		vim.fn.expand("%:p:h"),
		vim.fn.getcwd(),
	}

	for _, start in ipairs(starts) do
		if start and start ~= "" then
			local package_json = vim.fs.find("package.json", { path = start, upward = true, type = "file" })[1]
			if package_json then
				return vim.fs.dirname(package_json)
			end
		end
	end

	return vim.fn.getcwd()
end

local function configure_js(dap)
	local adapters = { "pwa-node", "pwa-chrome", "pwa-extensionHost" }
	for _, adapter in ipairs(adapters) do
		if not dap.adapters[adapter] then
			dap.adapters[adapter] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_server(), "${port}" },
				},
			}
		end
	end

	if not dap.adapters["node-terminal"] then
		dap.adapters["node-terminal"] = function(callback, config)
			config.type = "pwa-node"
			if not config.cwd or config.cwd == "${workspaceFolder}" or config.cwd == vim.fn.getcwd() then
				config.cwd = js_project_root()
			end
			config.console = config.console or "integratedTerminal"
			config.autoAttachChildProcesses = config.autoAttachChildProcesses ~= false

			if config.command and not config.runtimeExecutable then
				local command = require("dap.utils").splitstr(config.command)
				config.runtimeExecutable = table.remove(command, 1)
				config.runtimeArgs = command
				config.command = nil
			end

			callback(dap.adapters["pwa-node"])
		end
	end

	for _, adapter in ipairs({ "node", "chrome" }) do
		if not dap.adapters[adapter] then
			dap.adapters[adapter] = function(callback, config)
				config.type = "pwa-" .. adapter
				callback(dap.adapters[config.type])
			end
		end
	end

	local dap_vscode = require("dap.ext.vscode")
	vim.tbl_deep_extend("force", dap_vscode.type_to_filetypes, launchjs_type_to_filetypes())

	local configs = {
		{
			name = "Node: current file",
			type = "pwa-node",
			request = "launch",
			program = "${file}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**" },
		},
		{
			name = "Node: attach process",
			type = "pwa-node",
			request = "attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			sourceMaps = true,
		},
		{
			name = "Node: npm run dev",
			type = "pwa-node",
			request = "launch",
			cwd = "${workspaceFolder}",
			runtimeExecutable = "npm",
			runtimeArgs = { "run", "dev" },
			console = "integratedTerminal",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
		},
		{
			name = "Chrome: localhost:3000",
			type = "pwa-chrome",
			request = "launch",
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			sourceMaps = true,
		},
	}

	for _, filetype in ipairs(js_filetypes) do
		dap.configurations[filetype] = dap.configurations[filetype] or {}
		vim.list_extend(dap.configurations[filetype], vim.deepcopy(configs))
	end
end

return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>rB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint condition" },
			{ "<leader>rb", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>rc", function() require("dap").continue() end, desc = "Run/continue" },
			{ "<leader>ra", function() require("dap").continue({ before = get_args }) end, desc = "Run with args" },
			{ "<leader>rC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
			{ "<leader>rg", function() require("dap").goto_() end, desc = "Go to line without executing" },
			{ "<leader>ri", function() require("dap").step_into() end, desc = "Step into" },
			{ "<leader>rj", function() require("dap").down() end, desc = "Down stack frame" },
			{ "<leader>rk", function() require("dap").up() end, desc = "Up stack frame" },
			{ "<leader>rl", function() require("dap").run_last() end, desc = "Run last" },
			{ "<leader>rD", select_flutter_device, desc = "Select Flutter device" },
			{ "<leader>ro", function() require("dap").step_out() end, desc = "Step out" },
			{ "<leader>rO", function() require("dap").step_over() end, desc = "Step over" },
			{ "<leader>rP", function() require("dap").pause() end, desc = "Pause" },
			{ "<leader>rr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
			{ "<leader>rs", function() require("dap").session() end, desc = "Session" },
			{ "<leader>rt", terminate_debug, desc = "Terminate" },
			{ "<leader>rw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
		},
		init = function()
			if vim.g.whichkeyAddSpec then
				vim.g.whichkeyAddSpec({ "<leader>r", group = "Run/debug" })
			end
		end,
		config = function()
			local dap = require("dap")

			vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapStopped", {
				text = ">",
				texthl = "DiagnosticHint",
				linehl = "DiagnosticVirtualTextHint",
				numhl = "DiagnosticVirtualTextHint",
			})

			configure_vscode_launch_json()
			configure_launchjs_provider()
			dap.listeners.before.launch.asrma7_dapui_open = function()
				open_debug_ui()
			end
			dap.listeners.before.attach.asrma7_dapui_open = function()
				open_debug_ui()
			end
			configure_python(dap)
			configure_dart(dap)

			if vim.g.lualineAdd then
				vim.g.lualineAdd("sections", "lualine_y", {
					color = "DiagnosticInfo",
					function()
						local breakpoints = require("dap.breakpoints").get()
						local all_buffers = 0
						for _, buffer_breakpoints in pairs(breakpoints) do
							all_buffers = all_buffers + #buffer_breakpoints
						end

						if all_buffers == 0 then
							return ""
						end

						local current_buffer = #(breakpoints[vim.api.nvim_get_current_buf()] or {})
						return current_buffer == all_buffers and "B" .. current_buffer or "B" .. current_buffer .. "/" .. all_buffers
					end,
				}, "before")

				vim.g.lualineAdd("tabline", "lualine_z", function()
					local status = dap.status()
					return status == "" and "" or "DAP " .. status
				end)
			end
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		event = "VeryLazy",
		opts = {
			ensure_installed = { "python", "delve", "js" },
			automatic_installation = true,
		},
		config = function(_, opts)
			require("mason-nvim-dap").setup(opts)
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap" },
		keys = {
			{ "<leader>ru", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
			{ "<leader>re", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Evaluate expression" },
		},
		opts = {},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)

			dap.listeners.after.event_initialized.dapui_config = function()
				dapui.open()
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = "mfussenegger/nvim-dap",
		opts = {
			highlight_changed_variables = true,
			highlight_new_as_changed = false,
			only_first_definition = false,
			all_references = false,
		},
		keys = {
			{ "<leader>rv", function() require("nvim-dap-virtual-text").toggle() end, desc = "Toggle debug virtual text" },
		},
		config = function(_, opts)
			local dap_virtual_text = require("nvim-dap-virtual-text")
			dap_virtual_text.setup(opts)
			require("dap").listeners.after.disconnect.dap_virtual_text = dap_virtual_text.disable
		end,
	},
	{
		"microsoft/vscode-js-debug",
		ft = js_filetypes,
		build = build_js_debug,
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			configure_js(require("dap"))
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			require("dap-go").setup()
		end,
	},
}
