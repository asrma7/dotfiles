return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/cmp-path",
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"windwp/nvim-autopairs",
		},
		config = function()
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			luasnip.add_snippets("markdown", require("asrma7.snippets.notes"))
			luasnip.add_snippets("text", require("asrma7.snippets.notes"))
			luasnip.add_snippets("tex", require("asrma7.snippets.latex"))
			require("luasnip.loaders.from_vscode").lazy_load()

			local ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
			if ok then
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
