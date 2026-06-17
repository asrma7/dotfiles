return {
	name = "Go",
	treesitter = { "go", "gomod", "gosum", "gowork" },
	lsp = {
		gopls = {
			settings = {
				gopls = {
					gofumpt = true,
					staticcheck = true,
					analyses = {
						shadow = true,
						unusedparams = true,
					},
				},
			},
		},
	},
	formatters_by_ft = {
		go = { "gofumpt", "goimports" },
		gomod = { "gofmt" },
		gowork = { "gofmt" },
	},
}
