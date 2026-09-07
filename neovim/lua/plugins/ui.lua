vim.pack.add({
	-- colorscheme
	"https://github.com/navarasu/onedark.nvim",
	-- status line
	"https://github.com/nvim-lualine/lualine.nvim",
})

-- First setup to run: equivalent of lazy's priority = 1000.
vim.cmd.colorscheme("onedark")

require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "onedark",
		component_separators = { "", "" },
		section_separators = { "", "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { "filetype" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_c = { "filename" },
		lualine_x = { "location" },
	},
})
