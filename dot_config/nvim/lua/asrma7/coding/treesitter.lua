return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local parsers = require("asrma7.coding.utils").collect_list("treesitter")
			if not vim.tbl_contains(parsers, "regex") then
				table.insert(parsers, "regex")
				table.sort(parsers)
			end

			require("nvim-treesitter.install").prefer_git = false
			if require("asrma7.utils").get_os() == "windows" then
				require("nvim-treesitter.install").compilers = { "zig" }
			end

			require("nvim-treesitter").setup({
				ensure_installed = parsers,
				sync_install = false,
				auto_install = true,
				ignore_install = {},
				modules = {},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = {},
				},
			})
		end,
	},
}
