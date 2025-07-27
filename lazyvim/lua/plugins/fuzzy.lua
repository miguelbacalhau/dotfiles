return {
	"ibhagwan/fzf-lua",
	opts = {},
	config = function()
		require("fzf-lua").setup({
			fzf_opts = { ["--layout"] = "default", ["--marker"] = "+" },
			winopts = {
				height = 0.30, -- window height
				width = 1, -- window width
				row = 1, -- window row position (0=top, 1=bottom)
				col = 0, -- window col position (0=left, 1=right)
			},
		})

		-- See `:help telescope.builtin`
		local builtin = require("fzf-lua")
		vim.keymap.set("n", "<leader>p", builtin.files, { desc = "Search [F]iles" })
		vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Search open [B]uffers" })
		vim.keymap.set("n", "<leader>g", function()
			builtin.live_grep({ resume = true })
		end, { desc = "Search by [G]rep" })
		vim.keymap.set("n", "<leader>w", builtin.grep_cword, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>k", builtin.spellcheck, { desc = "Current Word Spell Suggestion" })
	end,
}
