return {
	{ "nmac427/guess-indent.nvim" },
	{
		"nvim-mini/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup()

			vim.keymap.set({ "n", "x" }, "s", "<Nop>")
		end,
	},
	{
		"nvim-mini/mini.jump2d",
		version = "*",
		config = function()
			require("mini.jump2d").setup({
				allowed_windows = {
					not_current = false,
				},
				view = {
					n_steps_ahead = 100,
				},
			})

			vim.keymap.set({ "n" }, "<CR>", function()
				MiniJump2d.start(MiniJump2d.builtin_opts.word_start)
			end)
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		config = function()
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
	},
}
