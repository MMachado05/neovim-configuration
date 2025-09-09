--  _____  _           _                               _   _    ___   __
-- |  __ \(_)         | |                             | | | |  | \ \ / /
-- | |  | |_ ___ _ __ | | __ _ _   _    __ _ _ __   __| | | |  | |\ V /
-- | |  | | / __| '_ \| |/ _` | | | |  / _` | '_ \ / _` | | |  | | > <
-- | |__| | \__ \ |_) | | (_| | |_| | | (_| | | | | (_| | | |__| |/ . \
-- |_____/|_|___/ .__/|_|\__,_|\__, |  \__,_|_| |_|\__,_|  \____//_/ \_\
--              | |             __/ |
--              |_|            |___/
-- Plugins relating to how the neovim viewport looks and behaves
return {
  -- --------------------
  -- Status Bars and Such
  -- --------------------
  {
    -- Might honestly get rid of this as soon as I've got a good buffer workflow
    "romgrk/barbar.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },
        sections = {
          lualine_x = { "hostname", "encoding", "fileformat", "filetype" },
        },
      })
    end,
  },

  -- -------------------
  -- Specialized windows
  -- -------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          window = {
            mappings = {
              ["?"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
            },
          },
        },
      })
    end,
  },
  {
    -- For previewing images and viewing them in Neovim
    -- "edluffy/hologram.nvim",
    -- This won't work until I switch to using Kitty and have installed ImageMagick.
    --  I also want 3rd/image.nvim for Neotree image previewing, so I'll have to look int
    --  that again.
  },
  {
    "mbbill/undotree",
    config = function()
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_TreeVertShape = "│"
      vim.g.undotree_TreeSplitShape = "󰁜"
      vim.g.undotree_TreeReturnShape = "╮"
      vim.g.undotree_TreeNodeShape = ""
    end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("aerial").setup({
        vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle! right<CR>")
      })
    end,
  },
  {
    "MunifTanjim/nui.nvim",
  },

  -- Prettying up existing features
  {
    -- Nicer notifications
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        max_width = 50,
      })
    end,
  },

  -- ---------------
  -- Visual Elements
  -- ---------------
  -- {
  --   "vhyrro/luarocks.nvim",
  --   priority = 2000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  --   config = true,
  -- },
  {
    -- "3rd/image.nvim", TODO: Fix this shit bro I wanna have images in markdownnnnnnuh.
    -- rocks = {
    --   hererocks = true,
    -- },
  },
  {
    "HakonHarnes/img-clip.nvim",
  },
  {
    -- NOTE: This requires the pynvim python package (pip3 install pynvim)
    "TaDaa/vimade",
  },
  {
    "folke/twilight.nvim",
  },
}
