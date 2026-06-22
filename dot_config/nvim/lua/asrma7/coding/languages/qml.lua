return {
	name = "QML",
	treesitter = { "qmljs", "qmldir" },
	lsp = {
		qmlls = {},
	},
	formatters_by_ft = {
		qml = { "qmlformat" },
		qmljs = { "qmlformat" },
	},
}
