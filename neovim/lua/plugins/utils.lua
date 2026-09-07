return {
	specs = {
		"https://github.com/miguelbacalhau/orca.nvim",
		"https://github.com/nmac427/guess-indent.nvim",
		{ src = "https://github.com/nvim-mini/mini.surround", version = vim.version.range("*") },
		{ src = "https://github.com/nvim-mini/mini.jump2d", version = vim.version.range("*") },
		{ src = "https://github.com/nvim-tree/nvim-tree.lua", version = vim.version.range("*") },
	},
	setup = function()
		require("orca").setup({
			mappings = {
				next = "<leader>q",
				prev = "<leader>Q",
				comment = "<leader>a",
				delete = "<leader>x",
				comment_next = "<leader>c",
				comment_prev = "<leader>C",
			},
		})

		-- guess-indent: lazy never called setup() (no opts/config) and the plugin
		-- has no plugin/ dir, so it was inert before; kept inert on purpose.

		require("mini.surround").setup()

		vim.keymap.set({ "n", "x" }, "s", "<Nop>")

		local MiniJump2d = require("mini.jump2d")

		MiniJump2d.setup({
			spotter = MiniJump2d.builtin_opts.word_start.spotter,
			allowed_windows = {
				not_current = false,
			},
			view = {
				n_steps_ahead = 100,
			},
			mappings = {
				start_jumping = "<leader>j",
			},
		})

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			renderer = {
				icons = {
					show = {
						file = false,
						folder = false,
					},
				},
			},
		})

		local api = require("nvim-tree.api")

		local find_file = function()
			api.tree.toggle({ focus = true, find_file = true })
		end

		vim.keymap.set("n", "<leader>;", find_file)
	end,
}
