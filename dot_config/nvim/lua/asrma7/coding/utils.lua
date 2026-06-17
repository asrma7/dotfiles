local M = {}

local languages = require("asrma7.coding.languages")

local function add_unique(target, seen, value)
	if value and not seen[value] then
		seen[value] = true
		table.insert(target, value)
	end
end

function M.collect_list(field)
	local result = {}
	local seen = {}

	for _, language in ipairs(languages) do
		for _, value in ipairs(language[field] or {}) do
			add_unique(result, seen, value)
		end
	end

	table.sort(result)
	return result
end

function M.collect_lsp_servers()
	local servers = {}

	for _, language in ipairs(languages) do
		for server, config in pairs(language.lsp or {}) do
			local server_config = vim.deepcopy(config or {})
			server_config.mason = nil
			servers[server] = vim.tbl_deep_extend("force", servers[server] or {}, server_config)
		end
	end

	return servers
end

function M.collect_lsp_server_names(predicate)
	local names = {}
	local seen = {}

	for _, language in ipairs(languages) do
		for server, config in pairs(language.lsp or {}) do
			if not predicate or predicate(server, config or {}) then
				add_unique(names, seen, server)
			end
		end
	end

	table.sort(names)
	return names
end

function M.collect_mason_lsp_server_names()
	return M.collect_lsp_server_names(function(_, config)
		return config.mason ~= false
	end)
end

function M.collect_local_lsp_server_names()
	return M.collect_lsp_server_names(function(_, config)
		return config.mason == false
	end)
end

function M.collect_formatters_by_ft()
	local formatters_by_ft = {}

	for _, language in ipairs(languages) do
		for filetype, formatters in pairs(language.formatters_by_ft or {}) do
			formatters_by_ft[filetype] = formatters
		end
	end

	return formatters_by_ft
end

return M
