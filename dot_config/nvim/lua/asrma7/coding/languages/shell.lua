return {
	name = "Shell",
	treesitter = { "bash", "nu" },
	lsp = {
		bashls = {},
	},
	formatters_by_ft = {
		bash = { "shfmt" },
		sh = { "shfmt" },
		zsh = { "shfmt" },
	},
}
