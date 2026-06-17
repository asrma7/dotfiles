return {
	name = "SQL",
	treesitter = { "sql" },
	lsp = {
		sqlls = {},
	},
	formatters_by_ft = {
		sql = { "sqlfmt" },
	},
}
