return {
	{ "nmac427/guess-indent.nvim" },
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup()

			vim.keymap.set({ "n", "x" }, "s", "<Nop>")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({
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
