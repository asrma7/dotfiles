local web_filetypes = {
	"html",
	"css",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"jsx",
	"tsx",
}

local function prettier()
	return { "prettierd", "prettier", stop_after_first = true }
end

return {
	name = "Web/Node/React",
	treesitter = { "css", "html", "javascript", "tsx", "typescript" },
	lsp = {
		cssls = {},
		eslint = {},
		html = {
			filetypes = web_filetypes,
		},
		tailwindcss = {
			filetypes = web_filetypes,
			root_dir = function(fname)
				return require("lspconfig").util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.cjs",
					"tailwind.config.mjs",
					"tailwind.config.ts",
					"postcss.config.js",
					"postcss.config.cjs",
					"postcss.config.mjs",
					"postcss.config.ts",
					"package.json",
					"node_modules",
					".git"
				)(fname)
			end,
		},
		emmet_language_server = {
			filetypes = vim.list_extend(vim.deepcopy(web_filetypes), { "markdown" }),
		},
		ts_ls = {},
	},
	formatters_by_ft = {
		css = prettier(),
		html = prettier(),
		javascript = prettier(),
		javascriptreact = prettier(),
		typescript = prettier(),
		typescriptreact = prettier(),
	},
}
