-- coreui 2
require("vim._core.ui2").enable({})

-- lazy.nvim enabled the byte-code cache implicitly; keep it.
vim.loader.enable()

require("config/options")
require("config/mappings")
require("config/autocmds")

require("config.pack")
