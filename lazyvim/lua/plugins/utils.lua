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
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup()

			local minifiles_toggle = function(...)
				if not MiniFiles.close() then
					MiniFiles.open(...)
				end
			end

			vim.keymap.set("n", "<leader>;", minifiles_toggle)
		end,
	},
}
