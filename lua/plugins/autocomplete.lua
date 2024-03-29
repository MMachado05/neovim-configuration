return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
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
		"saadparwaiz1/cmp_luasnip",
		dependencies = {
			"L3MON4D3/LuaSnip",
		},
	},
	{
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
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<S-tab>"] = cmp.mapping.select_prev_item(),
					["<tab>"] = cmp.mapping.select_next_item(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					-- Now, each luatable has decreasing priority
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}, {
					{ name = "buffer", max_item_count = 6 },
				}),
			})
		end,
	},
}
