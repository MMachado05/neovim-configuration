return {
  {
    "d00h/nvim-rusticated",
    name = "rusticated-theme",
    lazy = false,
    priority = 900,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" }
  },
  {
    -- DARK THEMES INCLUDED:  gruvbox ("set background=dark")
    -- LIGHT THEMES INCLUDED: gruvbox ("set background=light")
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox-theme",
    lazy = false,
    priority = 1000,
    config = true,
    opts = ...,
  },
  {
    -- DARK THEMES INCLUDED:  kanagawa/kanagawa-wave, kanagawa-dragon
    -- LIGHT THEMES INCLUDED: kanagawa-lotus
    "rebelot/kanagawa.nvim",
    name = "kanagawa-theme",
    lazy = false,
    priority = 900,
  },
  {
    -- DARK THEMES INCLUDED:  material/material-palenight, material-darker, material-deep-ocean, material-oceanic,
    -- LIGHT THEMES INCLUDED: material-lighter,
    "marko-cerovac/material.nvim",
    name = "material-theme",
    lazy = false,
    priority = 875,
  },
  {
    "Mofiqul/adwaita.nvim",
    name = "adwaita-theme",
    lazy = false,
    priority = 850,
  },
  {
    -- DARK THEMES INCLUDED:  nightfox, duskfox, nordfox, terafox, carbonfox
    -- LIGHT THEMES INCLUDED: dayfox, dawnfox
    "EdenEast/nightfox.nvim",
    name = "nightfox-theme",
    lazy = false,
    priority = 850,
    config = function()
      require("nightfox").setup({
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            strings = "italic",
          },
        },
      })
    end,
  },
  {
    -- DARK THEMES INCLUDED:  rose-pine/rose-pine-main, rose-pine-moon
    -- LIGHT THEMES INCLUDED: rose-pine-dawn
    "rose-pine/neovim",
    name = "rose-pine-theme",
    lazy = false,
    priority = 825,
  },
  {
    -- DARK THEMES INCLUDED:  everforest ("set background=dark")
    -- LIGHT THEMES INCLUDED: everforest ("set background=light")
    "neanias/everforest-nvim",
    name = "everforest-theme",
    lazy = false,
    priority = 800,
  },
  {
    -- DARK THEMES INCLUDED:  catppuccin/catppuccin-mocha, catppuccin-frappe, catppuccin-macchiato
    -- LIGHT THEMES INCLUDED: catppuccin-latte
    "catppuccin/nvim",
    name = "catppuccin-theme",
    lazy = false,
    priority = 700,
  },
  {
    -- DARK THEMES INCLUDED:  melange ("set background=dark")
    -- LIGHT THEMES INCLUDED: melange ("set background=light")
    "savq/melange-nvim",
    name = "melange-theme",
    lazy = false,
    priority = 600,
  },
}
