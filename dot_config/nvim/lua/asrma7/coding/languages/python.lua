return {
	name = "Python",
	treesitter = { "python" },
	lsp = {
		pyright = {},
		ruff = {},
	},
	formatters_by_ft = {
		python = { "black" },
	},
}
