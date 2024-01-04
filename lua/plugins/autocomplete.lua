return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		config = function()
			local ls = require("luasnip")
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

			ls.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
			})

      -- TODO: figure out how to jump between nodes lmao
      vim.cmd("command LuasnipEdit execute 'vsplit | edit ~/.config/nvim/snippets/' . expand('%:e') . '.lua'")
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
					["<C-j>"] = cmp.mapping.select_prev_item(),
					["<C-k>"] = cmp.mapping.select_next_item(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					-- Now, each luatable has decreasing priority
					-- { name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer", max_item_count = 6 },
					{ name = "path" },
				}),
			})
		end,
	},
}
