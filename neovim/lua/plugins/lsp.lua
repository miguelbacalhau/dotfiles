return {
	specs = {
		-- LSP Plugins
		-- Automatically install LSPs and related tools to stdpath for Neovim
		"https://github.com/mason-org/mason.nvim",
		"https://github.com/mason-org/mason-lspconfig.nvim",
		"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Useful status updates for LSP.
		"https://github.com/j-hui/fidget.nvim",
		-- Main LSP Configuration
		"https://github.com/neovim/nvim-lspconfig",
		-- Autoformat
		"https://github.com/stevearc/conform.nvim",
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
		"https://github.com/rafamadriz/friendly-snippets",
		{ src = "https://github.com/nvim-mini/mini.snippets", version = vim.version.range("*") },
	},
	setup = function()
		-- Mason must be set up before its dependents.
		require("mason").setup({})
		require("fidget").setup({})

		--  This function gets run when an LSP attaches to a particular buffer.
		--    That is to say, every time a new file is opened that is associated with
		--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
		--    function will be executed to configure the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),

			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "[LSP]: " .. desc })
				end

				map("<leader>cr", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code actions", { "n", "x" })
				map("<leader>r", require("fzf-lua").lsp_references, "References")
				map("<leader>i", require("fzf-lua").lsp_implementations, "Implementation")
				map("<leader>d", require("fzf-lua").lsp_definitions, "Definition")

				map("<leader>D", vim.lsp.buf.declaration, "Declaration")
				map("<leader>o", require("fzf-lua").lsp_document_symbols, "Document Symbols")
				map("<leader>cw", require("fzf-lua").lsp_live_workspace_symbols, "Workspace Symbols")
				map("<leader>t", require("fzf-lua").lsp_typedefs, "Type Definition")
				map("<leader>h", vim.lsp.buf.hover, "Hover")
				map("<leader>e", require("fzf-lua").lsp_workspace_diagnostics, "Diagnostics")
				map("<leader>n", vim.diagnostic.goto_next, "Next Diagnostic")
				map("<leader>N", vim.diagnostic.goto_prev, "Previous Diagnostic")

				-- Enable Neovim's built-in LSP completion (Neovim >= 0.11). No
				-- autotrigger: this just wires up 'omnifunc', so completion is
				-- requested with the classic <C-x><C-o>. This is what surfaces the
				-- snippets served by the mini.snippets in-process LSP server.
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method("textDocument/completion") then
					vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })
				end
			end,
		})

		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		-- vue_ls is only a thin server for the template/style parts of SFCs; all
		-- TypeScript requests are forwarded to a ts server (vtsls here) that must
		-- load @vue/typescript-plugin from the vue-language-server install.
		local vue_plugin = {
			name = "@vue/typescript-plugin",
			location = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
			languages = { "vue" },
			configNamespace = "typescript",
		}

		local servers = {

			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},

			vtsls = {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								vue_plugin,
							},
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			},

			vue_ls = {},
		}

		for name, config in pairs(servers) do
			vim.lsp.config(name, config)
		end

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- mason-lspconfig v2 auto-enables every Mason-installed server via
		-- vim.lsp.enable; the v1 handlers/automatic_installation options are gone.
		require("mason-lspconfig").setup()

		-- conform: eager. Its setup() registers the BufWritePre autocmd itself;
		-- plugin/conform.lua (ConformInfo) is sourced by packadd at load-plugins.
		require("conform").setup({
			notify_on_error = false,
			-- Never fall back to LSP formatting on save: vtsls attaches to
			-- vue/ts/js buffers and its tsserver-style formatting fights the
			-- project's Prettier config. Only explicit formatters_by_ft run.
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "never",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		})

		vim.keymap.set("", "<leader>cf", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "Format Code" })

		-- nvim-treesitter (main branch). lazy's main = "nvim-treesitter.config".
		require("nvim-treesitter.config").setup({
			ensure_installed = {
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = { enable = true },
		})

		local MiniSnippets = require("mini.snippets")

		MiniSnippets.setup({
			snippets = {
				MiniSnippets.gen_loader.from_lang(), -- loads friendly-snippets
			},
		})

		MiniSnippets.start_lsp_server({ match = false })

		-- Native completion expands snippets via vim.snippet on accept; these jump
		-- between tabstops. Returning "<Cmd>...<CR>" from an expr map avoids the
		-- textlock restriction on editing the buffer mid-expression.
		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if vim.snippet.active({ direction = 1 }) then
				return "<Cmd>lua vim.snippet.jump(1)<CR>"
			end
			return "<C-l>"
		end, { expr = true, silent = true, desc = "Snippet: jump forward" })

		vim.keymap.set({ "i", "s" }, "<C-h>", function()
			if vim.snippet.active({ direction = -1 }) then
				return "<Cmd>lua vim.snippet.jump(-1)<CR>"
			end
			return "<C-h>"
		end, { expr = true, silent = true, desc = "Snippet: jump backward" })
	end,
}
