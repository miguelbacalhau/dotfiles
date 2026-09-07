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

-- Order matters for setup(): colorscheme first, mason before mason-lspconfig.
local modules = { "plugins.ui", "plugins.fuzzy", "plugins.git", "plugins.lsp", "plugins.utils" }

local specs, setups = {}, {}
for _, name in ipairs(modules) do
	local mod = require(name)
	vim.list_extend(specs, mod.specs)
	if mod.setup then
		setups[#setups + 1] = { name = name, fn = mod.setup }
	end
end

-- One call: installs missing plugins in parallel (no prompt, like lazy did),
-- then :packadd!'s every plugin so all lua/ and colors/ dirs are on 'rtp'
-- before any setup() below runs.
vim.pack.add(specs, { confirm = false })

-- Run every setup() even if one raises, then report all failures together.
-- An unguarded loop stops at the first error and leaves every later module
-- unconfigured, so one broken plugin takes out unrelated ones. Failures are
-- still fatal -- nothing is swallowed. vim.pack.add() collects errors the same
-- way (see `errors` in runtime/lua/vim/pack.lua).
local errors = {}
for _, setup in ipairs(setups) do
	local ok, err = pcall(setup.fn)
	if not ok then
		errors[#errors + 1] = ("`%s`:\n%s"):format(setup.name, err)
	end
end

if #errors > 0 then
	error(("config.pack:\n\n%s"):format(table.concat(errors, "\n\n")))
end
