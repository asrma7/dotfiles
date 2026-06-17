return {
	name = "Markdown",
	treesitter = { "markdown", "markdown_inline" },
	lsp = {
		marksman = {},
	},
	formatters_by_ft = {
		markdown = { "prettierd", "prettier", stop_after_first = true },
	},
}
