--  _____ _____  ______   ______         _
-- |_   _|  __ \|  ____| |  ____|       | |
--   | | | |  | | |__    | |__ ___  __ _| |_ _   _ _ __ ___  ___
--   | | | |  | |  __|   |  __/ _ \/ _` | __| | | | '__/ _ \/ __|
--  _| |_| |__| | |____  | | |  __/ (_| | |_| |_| | | |  __/\__ \
-- |_____|_____/|______| |_|  \___|\__,_|\__|\__,_|_|  \___||___/
-- Plugins relating to the large-scale process of how code is written

return {
	-- -------------------------------------------
	-- Treesitter for stronger syntax highlighting
	-- -------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				auto_install = false,
				ensure_installed = {
					"vim",
					"vimdoc",
					"markdown",
					"python",
					"java",
					"c",
					"lua",
				},
				highlight = { enable = true },
				indent = { enable = true },
				fold = { enable = true },
			})
		end,
	},

	-- ----------------------------
	-- LSP configuration and Mason for installing LSPs
	-- ----------------------------
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local none_ls = require("null-ls")
			none_ls.setup({
				sources = {
					-- Lua
					none_ls.builtins.formatting.stylua,

					-- Java
					none_ls.builtins.formatting.google_java_format,
					none_ls.builtins.diagnostics.checkstyle.with({
						extra_args = { "-c", "/google_checks.xml" },
					}),

					-- Python
					none_ls.builtins.formatting.black,

					-- Markdown
					none_ls.builtins.formatting.mdformat,
					-- Like it says elsewhere, this should all eventually be done with mason-null-ls
				},
			})

			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup all LSPs in "ensure_installed"
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, {}) -- Maybe there's a way to get the command line prompt to appear in a floating window right here?
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			-- TODO: Move these out into a single "shortcuts" file
			vim.cmd("command AddLsp vsplit | edit ~/.config/nvim/lua/plugins/code_editing.lua")
		end,
	},
	-- Mason for installing new language servers
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- Python
					"pyright", -- LSP
					"black", -- Formatter

					-- Lua
					"lua_ls", -- LSP
					"stylua", -- Formatter

					-- Rust
					"rust_analyzer", -- LSP

					-- Java
					"jdtls", -- LSP
					"checkstyle", -- Linter
					"google-java-format", -- Formatter
					-- TODO: This shit's brokey but mason-null-ls seems like a good way to fix it.
					--  Might even allow me to move all the "ensured" stuff somewhere else, too.

					-- XML
					"lemminx",

					-- Markdown
					"marksman", -- LSP
				},
			})
		end,
	},

	-- ----------------------------
	-- Autocomplete functionalities
	-- ----------------------------
	{
		-- Basic autocomplete requirement
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			-- Set up nvim-cmp.
			local cmp = require("cmp")
			local ls = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<S-tab>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-2),
					["<C-f>"] = cmp.mapping.scroll_docs(2),
					["<tab>"] = cmp.mapping.select_next_item(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					-- Now, each luatable has decreasing priority
					{ name = "nvim_lsp" }, -- LSP has highest priority
					{ name = "luasnip" }, -- Next is personal snippets (might change this)
					{ name = "path" }, -- Finally, anything relating to filepaths
				}, {
					{ name = "buffer", max_item_count = 6 },
				}),
			})
		end,
	},
	{
		-- Autocompletion with LSPs
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		-- Snippets
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		config = function()
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

			luasnip.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				ext_opts = {
					[require("luasnip.util.types").choiceNode] = {
						active = {
							virt_text = { { "●", "GruvboxPurple" } },
						},
					},
				},
			})

			vim.keymap.set({ "i", "s" }, "<a-l>", function()
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				end
			end)
			vim.keymap.set({ "i", "s" }, "<a-h>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end)

			vim.keymap.set({ "i", "s" }, "<a-j>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				end
			end)
			vim.keymap.set({ "i", "s" }, "<a-k>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(-1)
				end
			end)
			vim.cmd("command LuaSnipEdit execute 'vsplit | edit ~/.config/nvim/snippets/' . expand('%:e') . '.lua'")
		end,
	},
	{
		-- Autocomplete with snippets
		"saadparwaiz1/cmp_luasnip",
	},
	{
		-- AI-assisted code completion
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			vim.cmd("CodeiumDisable")
		end,
	},

	-- ----------------
	-- Code Diagnostics
	-- ----------------
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = true, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#CC241D" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FABD2F" },
				info = { "DiagnosticInfo", "#458588" },
				hint = { "DiagnosticHint", "#689D68" },
				default = { "Identifier", "#076678" },
				test = { "Identifier", "#B16286" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
		config = function()
			require("todo-comments").setup()

			vim.cmd("command Todos TodoTrouble")
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			-- TODO: Move all vim keymaps to a separate file

			vim.keymap.set("n", "<leader>tr", ":TroubleToggle<CR>", {})
		end,
	},

	-- ------------------------------
	-- Vimtex for LaTeX, specifically
	-- ------------------------------
	{
		"lervag/vimtex",
		lazy = false,
	},
}
