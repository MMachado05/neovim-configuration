vim.cmd("set number relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.cmd("set cc=90")

vim.keymap.set('n', '<leader>wh', '<C-W>h', {})
vim.keymap.set('n', '<leader>wj', '<C-W>j', {})
vim.keymap.set('n', '<leader>wk', '<C-W>k', {})
vim.keymap.set('n', '<leader>wl', '<C-W>l', {})
vim.keymap.set('n', '<leader>rr', '<C-R>', {})

vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', {})
vim.keymap.set('n', '<leader>sh', ':split<CR>', {})

vim.cmd("noremap <expr> j v:count ? 'j' : 'gj'")
vim.cmd("noremap <expr> k v:count ? 'k' : 'gk'")
