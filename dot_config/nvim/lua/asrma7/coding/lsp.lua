local coding = require("asrma7.coding.utils")

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		init = function()
			if vim.g.whichkeyAddSpec then
				vim.g.whichkeyAddSpec({ "<leader>l", group = "LSP" })
			end
		end,
		config = function()
			local servers = coding.collect_lsp_servers()
			local mason_server_names = coding.collect_mason_lsp_server_names()
			local local_server_names = coding.collect_local_lsp_server_names()

			local highlight_group = vim.api.nvim_create_augroup("asrma7-lsp-document-highlight", { clear = false })
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("asrma7-lsp-attach", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf }
					local function map(mode, keys, rhs, desc)
						vim.keymap.set(mode, keys, rhs, vim.tbl_extend("force", opts, { desc = desc }))
					end

					map("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
					map("n", "gr", vim.lsp.buf.references, "LSP: references")
					map("n", "K", vim.lsp.buf.hover, "LSP: hover docs")
					map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: rename")
					map("n", "<leader>vrn", vim.lsp.buf.rename, "LSP: rename")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
					map({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, "LSP: code action")
					map("n", "<leader>ld", vim.diagnostic.open_float, "LSP: line diagnostics")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = event.buf })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							group = highlight_group,
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							group = highlight_group,
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			vim.diagnostic.config({
				severity_sort = true,
				update_in_insert = false,
				underline = true,
				virtual_text = {
					prefix = "-",
					spacing = 4,
				},
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = true,
					header = "",
					prefix = "",
				},
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if ok then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end

			for server, config in pairs(servers) do
				config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
				vim.lsp.config(server, config)
			end

			require("mason").setup({
				PATH = "prepend",
			})

			require("mason-lspconfig").setup({
				ensure_installed = mason_server_names,
				automatic_enable = mason_server_names,
			})

			if #local_server_names > 0 then
				vim.lsp.enable(local_server_names)
			end
		end,
	},
}
