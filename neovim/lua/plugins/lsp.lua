return {
	-- LSP Plugins
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
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

			-- Broadcast Neovim's built-in capabilities to every server. The defaults
			-- already advertise `completionItem.snippetSupport`, which is required for
			-- snippet completion items to be returned and expanded natively.
			local capabilities = vim.lsp.protocol.make_client_capabilities()

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
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format Code",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.config",
		branch = "main",
		opts = {
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
		},
	},
	{
		"nvim-mini/mini.snippets",
		version = "*",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
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
	},
}
