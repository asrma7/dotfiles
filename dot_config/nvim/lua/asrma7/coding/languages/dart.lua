return {
	name = "Dart/Flutter",
	treesitter = { "dart" },
	lsp = {
		dartls = {
			mason = false,
			root_markers = { "pubspec.yaml" },
			init_options = {
				onlyAnalyzeProjectsWithOpenFiles = true,
				suggestFromUnimportedLibraries = true,
				closingLabels = true,
				outline = true,
				flutterOutline = true,
			},
			settings = {
				dart = {
					completeFunctionCalls = true,
					showTodos = true,
				},
			},
		},
	},
	formatters_by_ft = {
		dart = { "dart_format" },
	},
}
