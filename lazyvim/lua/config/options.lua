-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
-- vim.schedule(function()
-- 	vim.o.clipboard = "unnamedplus"
-- end)

-- identation
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.ai = true

-- Save undo history
vim.o.undofile = true
vim.o.swapfile = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Floating window border
vim.o.winborder = "bold"

-- Complition menu options
vim.o.completeopt = "menu,menuone,popup,fuzzy,noselect"
