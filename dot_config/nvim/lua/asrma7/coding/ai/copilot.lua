return {
	{
		"github/copilot.vim",
		init = function()
			vim.g.copilot_filetypes = vim.tbl_extend("force", vim.g.copilot_filetypes or {}, {
				AgenticInput = true,
			})
		end,
	},
}
