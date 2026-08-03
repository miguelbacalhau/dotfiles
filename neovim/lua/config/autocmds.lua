-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Associate .typ extension with 'typ' filetype
vim.filetype.add({
	extension = {
		typ = "typ",
	},
})

-- Enable spell checking for .typ files
vim.api.nvim_create_autocmd("FileType", {
	desc = "Spell check typst files",
	pattern = "typ",
	callback = function()
		vim.opt_local.spell = true -- enable spell checking
		vim.opt_local.spelllang = { "en" } -- set language(s), e.g. English
		vim.opt_local.colorcolumn = "80"
	end,
})
