return {
	{
		"carlos-algms/agentic.nvim",
		opts = {
			provider = vim.g.asrma7_agentic_provider or vim.env.AGENTIC_PROVIDER or "codex-acp",
			acp_providers = {
				["codex-acp"] = {
					name = "Codex ACP",
					command = vim.env.CODEX_ACP_CMD or "codex-acp",
					env = {},
				},
				["opencode-acp"] = {
					name = "OpenCode ACP",
					command = vim.env.OPENCODE_CMD or "opencode",
					args = { "acp" },
					env = {},
				},
			},
			provider_switcher = {
				hide_unhealthy_providers = false,
			},
			keymaps = {
				widget = {
					switch_provider = {
						"<localLeader>s",
						{ "<C-]>", mode = { "n", "v", "i" } },
					},
				},
			},
		},
		keys = {
			{ "<C-g>", function() require("agentic").stop_generation() end, mode = { "n", "v", "i" }, desc = "Stop Agentic" },
			{ "<leader>aa", function() require("agentic").toggle() end, mode = { "n", "v" }, desc = "Toggle Agentic" },
			{ "<leader>ac", function() require("agentic").add_selection_or_file_to_context() end, mode = { "n", "v" }, desc = "Add context" },
			{ "<leader>an", function() require("agentic").new_session() end, mode = { "n", "v" }, desc = "New session" },
			{ "<leader>ao", function() require("agentic").switch_provider({ provider = "opencode-acp" }) end, mode = { "n", "v" }, desc = "Use OpenCode" },
			{ "<leader>ap", function() require("agentic").switch_provider() end, mode = { "n", "v" }, desc = "Switch provider" },
			{ "<leader>ar", function() require("agentic").restore_session() end, mode = { "n", "v" }, desc = "Restore session" },
			{ "<leader>as", function() require("agentic").stop_generation() end, mode = { "n", "v" }, desc = "Stop generation" },
			{ "<leader>ax", function() require("agentic").switch_provider({ provider = "codex-acp" }) end, mode = { "n", "v" }, desc = "Use Codex" },
			{ "<leader>ad", function() require("agentic").add_current_line_diagnostics() end, desc = "Add line diagnostic" },
			{ "<leader>aD", function() require("agentic").add_buffer_diagnostics() end, desc = "Add buffer diagnostics" },
		},
		init = function()
			if vim.g.whichkeyAddSpec then
				vim.g.whichkeyAddSpec({ "<leader>a", group = "AI" })
			end
		end,
	},
}
