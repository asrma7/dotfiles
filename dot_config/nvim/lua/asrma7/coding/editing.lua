return {
	{
		"Wansmer/treesj",
		keys = { "<space>lm", "<space>lj", "<space>ls" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"echasnovski/mini.surround",
		opts = {
			custom_surroundings = nil,
			highlight_duration = 500,
			mappings = {
				add = "sa",
				delete = "sd",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				replace = "sr",
				update_n_lines = "sn",
				suffix_last = "l",
				suffix_next = "n",
			},
			n_lines = 20,
			respect_selection_type = false,
			search_method = "cover",
			silent = false,
		},
	},
	{
		"abecodes/tabout.nvim",
		-- Disabled while Copilot owns <Tab>; re-enable if Copilot is removed.
		enabled = false,
		event = "InsertCharPre",
		priority = 1000,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			tabkey = "",
			backwards_tabkey = "<S-Tab>",
			act_as_tab = true,
			act_as_shift_tab = false,
			default_tab = "<C-t>",
			default_shift_tab = "<C-d>",
			enable_backwards = true,
			completion = false,
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
			},
			ignore_beginning = true,
			exclude = {},
		},
		config = function(_, opts)
			require("tabout").setup(opts)
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
}
