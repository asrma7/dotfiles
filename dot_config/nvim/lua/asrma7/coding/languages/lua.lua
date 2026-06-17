return {
	name = "Lua/Vim",
	treesitter = { "lua", "luadoc", "vim", "vimdoc" },
	lsp = {
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		},
		vimls = {},
	},
	formatters_by_ft = {
		lua = { "stylua" },
	},
}
