return {
	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = { "n", "v" },
				desc = "Format buffer/range",
			},
		},
		config = function()
			vim.g.disable_autoformat = true

			require("conform").setup({
				formatters_by_ft = require("asrma7.coding.utils").collect_formatters_by_ft(),
				formatters = {
					prettierd = {
						prepend_args = { "--tab-width", "4", "--use-tabs" },
						require_cwd = true,
					},
					prettier = {
						prepend_args = { "--tab-width", "4", "--use-tabs" },
					},
				},
				format_on_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return nil
					end

					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end,
			})

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.g.disable_autoformat = false
			end, {})

			vim.api.nvim_create_user_command("FormatDisable", function()
				vim.g.disable_autoformat = true
			end, {})

			vim.api.nvim_create_user_command("FormatToggle", function()
				vim.g.disable_autoformat = not vim.g.disable_autoformat
			end, {})
		end,
	},
}
