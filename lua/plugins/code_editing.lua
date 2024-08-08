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

  -- ------------------------------
  -- Vimtex for LaTeX, specifically
  -- ------------------------------
  {
    "lervag/vimtex",
    lazy = false,
  },
}
