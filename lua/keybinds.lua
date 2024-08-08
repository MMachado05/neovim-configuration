-- --------------------
-- Vim-related Keybinds
-- --------------------
vim.g.mapleader = " "

-- Allow j/k through wrapped lines
vim.cmd("noremap <expr> j v:count ? 'j' : 'gj'")
vim.cmd("noremap <expr> k v:count ? 'k' : 'gk'")

-- Moving across windows
vim.keymap.set("n", "<leader>wh", "<C-W>h", {})
vim.keymap.set("n", "<leader>wj", "<C-W>j", {})
vim.keymap.set("n", "<leader>wk", "<C-W>k", {})
vim.keymap.set("n", "<leader>wl", "<C-W>l", {})
vim.keymap.set("n", "<leader>rr", "<C-R>", {})

-- Creating new windows
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", {})
vim.keymap.set("n", "<leader>sh", ":split<CR>", {})

-- Moving across buffers
vim.keymap.set("n", "<leader>bp", ":bp<CR>", {})
vim.keymap.set("n", "<leader>bn", ":bn<CR>", {})

-- ----------------------
-- Preferred Colorschemes
-- ----------------------
-- Dark mode colorschemes
vim.keymap.set("n", "<leader>lq", ":colorscheme gruvbox | set background=dark<CR>", {})
vim.keymap.set("n", "<leader>lw", ":colorscheme catppuccin-macchiato | set background=dark<CR>", {})

-- Light mode colorschemes
vim.keymap.set("n", "<leader>le", ":colorscheme dawnfox<CR>", {})
vim.keymap.set("n", "<leader>lr", ":colorscheme adwaita | set background=light<CR>", {})

-- -----------------------
-- Plugin-related Keybinds
-- -----------------------
-- Vimtex
vim.g.vimtex_quickfix_open_on_warning = 0
