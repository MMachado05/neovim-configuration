local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Import vim options and plugin information
require("vim-configs")
require("lazy").setup("plugins")

-- Set default colorscheme
vim.opt.termguicolors = true
vim.cmd.colorscheme "gruvbox"
