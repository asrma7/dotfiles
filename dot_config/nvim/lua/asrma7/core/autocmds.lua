local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local asrma7_group = augroup("asrma7", {})
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = asrma7_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.x", "*.xm", "*.mm" },
	callback = function()
		vim.bo.filetype = "objc"
	end,
})
