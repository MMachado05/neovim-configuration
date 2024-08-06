return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      auto_install = false,
      ensure_installed = {"vim", "vimdoc", "markdown", "python", "java", "c", "lua"},
      highlight = { enable = true },
      indent = { enable = true },
      fold = { enable = true },
    })
  end,
}
