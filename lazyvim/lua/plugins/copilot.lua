return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = false,
				},
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				adapters = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								model = {
									default = "claude-3.7-sonnet",
								},
							},
						})
					end,
				},
				strategies = {
					chat = {
						adapter = "copilot",
					},
					agent = {
						adapter = "copilot",
					},
					inline = {
						adapter = "copilot",
					},
				},
			})

			vim.keymap.set("v", "<leader>a", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>z", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		end,
	},
}
