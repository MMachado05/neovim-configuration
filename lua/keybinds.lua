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
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, {}) -- Maybe there's a way to get the command line prompt to appear in a floating window right here?
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, {})
vim.keymap.set({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, {})

-- ----------------------
-- Preferred Colorschemes
-- ----------------------
vim.cmd("command FloatBorderBGOff lua vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })")

-- Dark mode colorschemes
vim.keymap.set("n", "<leader>dp", ":colorscheme gruvbox | set background=dark | FloatBorderBGOff<CR>", {})
vim.keymap.set("n", "<leader>do", ":colorscheme zenbones | FloatBorderBGOff<CR>", {})
vim.keymap.set("n", "<leader>di", ":colorscheme kanagawa-dragon | FloatBorderBGOff<CR>", {})
vim.keymap.set("n", "<leader>du", ":colorscheme terafox | FloatBorderBGOff<CR>", {})

-- Light mode colorschemes
vim.keymap.set("n", "<leader>lq", ":colorscheme material-lighter | FloatBorderBGOff<CR>", {})
vim.keymap.set("n", "<leader>lw", ":colorscheme rose-pine-dawn | FloatBorderBGOff<CR>", {})
vim.keymap.set("n", "<leader>le", ":colorscheme rose-pine-dawn | FloatBorderBGOff<CR>", {})
vim.keymap.set("n", "<leader>lr", ":colorscheme rose-pine-dawn | FloatBorderBGOff<CR>", {})

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
vim.keymap.set("n", "<leader>nf", ":Neotree position=float<CR>", {})

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

local spelling = require("mmachado.layouts.telescope_spelling")
vim.keymap.set("n", "<leader>ss", function()
	telescope_builtin.spell_suggest({ create_layout = spelling })
end)

-- LuaSnip
local luasnip = require("luasnip")
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
