return {
	{
		"RRethy/base16-nvim",
		lazy = false,
		priority = 1001,
		config = function()
			require("asrma7.matugen").source({ silent = true })
		end,
	},
}
