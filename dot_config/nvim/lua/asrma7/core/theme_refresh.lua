local M = {}

function M.refresh()
	require("asrma7.matugen").source()

	dofile(vim.fn.stdpath("config") .. "/lua/asrma7/lazy/lualine.lua")

	vim.api.nvim_set_hl(0, "Comment", { italic = true })
end

function M.setup()
	vim.api.nvim_create_autocmd("Signal", {
		pattern = "SIGUSR1",
		callback = M.refresh,
	})

	M.refresh()
end

return M
