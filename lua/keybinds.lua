-- --------------------
-- Vim-related Keybinds
-- --------------------
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

-- LSP features
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, {}) -- Maybe there's a way to get the command line prompt to appear in a floating window right here?
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

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
-- Trouble
vim.keymap.set("n", "<leader>tr", ":TroubleToggle<CR>", {})

-- Neotree
vim.keymap.set("n", "<leader>nol", ":Neotree filesystem reveal left<CR>", {})
vim.keymap.set("n", "<leader>nor", ":Neotree filesystem reveal right<CR>", {})
vim.keymap.set("n", "<leader>ntl", ":Neotree filesystem toggle left<CR>", {})
vim.keymap.set("n", "<leader>ntr", ":Neotree filesystem toggle right<CR>", {})

-- Undotree
vim.keymap.set("n", "<leader>us", ":UndotreeShow<CR>", {})
vim.keymap.set("n", "<leader>uc", ":UndotreeHide<CR>", {})
vim.keymap.set("n", "<leader>uf", ":UndotreeFocus<CR>", {})

-- Twilight
vim.keymap.set("n", "<leader>te", ":TwilightEnable<CR>")
vim.keymap.set("n", "<leader>td", ":TwilightDisable<CR>")

-- Telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
