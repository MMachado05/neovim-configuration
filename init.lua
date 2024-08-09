-- Set up leader key at the outset
vim.g.mapleader = " "

-- Ensure lazy.nvim is installed
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
require("lazy").setup("plugins")
require("setup")
require("commands")
require("keybinds")

-- Set default colorscheme
vim.opt.termguicolors = true
vim.cmd.colorscheme "gruvbox"
vim.cmd([[autocmd BufNewFile,BufRead *.launch setfiletype xml]])
