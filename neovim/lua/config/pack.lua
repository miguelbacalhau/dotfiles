-- Plugin management with the built-in vim.pack (:h vim.pack).
-- Lockfile: <config>/nvim-pack-lock.json (committed).

-- Build hooks must exist before the first vim.pack.add() so they also fire for
-- installs driven by the lockfile.
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("config-pack-hooks", { clear = true }),
	callback = function(ev)
		if ev.data.spec.name ~= "nvim-treesitter" then
			return
		end
		if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
			return
		end
		-- On install the plugin is not on 'runtimepath' yet; add it (no plugin/
		-- sourcing: that happens in the normal load-plugins step).
		if not ev.data.active then
			vim.cmd.packadd({ "nvim-treesitter", bang = true })
		end
		-- Exactly what :TSUpdate runs (plugin/nvim-treesitter.lua). Asynchronous,
		-- like lazy's `build = ":TSUpdate"` was.
		require("nvim-treesitter.install").update({}, { summary = true })
	end,
})

-- Each module calls vim.pack.add() for its own plugins and configures them
-- immediately after, which is the shape :h vim.pack models. Order matters:
-- plugins.ui applies the colorscheme first, and inside plugins.lsp mason is
-- set up before mason-lspconfig. Tradeoff: a first install on a new machine
-- clones one module at a time instead of all plugins in parallel.
local modules = { "plugins.ui", "plugins.fuzzy", "plugins.git", "plugins.lsp", "plugins.utils" }

-- Load every module even if one raises, then report all failures together.
-- Stopping at the first error would leave every later module unconfigured, so
-- one broken plugin takes out unrelated ones. Nothing is swallowed: a failure
-- is still fatal. vim.pack.add() collects errors the same way.
local errors = {}
for _, name in ipairs(modules) do
	local ok, err = pcall(require, name)
	if not ok then
		errors[#errors + 1] = ("`%s`:\n%s"):format(name, err)
	end
end

if #errors > 0 then
	error(("config.pack:\n\n%s"):format(table.concat(errors, "\n\n")))
end
