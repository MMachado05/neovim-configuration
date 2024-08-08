-- Window manipulation
-- vim.cmd("command ")

-- Misc.
-- TODO: This just let's me quickly add new setup stuff; I should probably have a better
--  command name.
vim.cmd("command AddLsp vsplit | edit ~/.config/nvim/lua/plugins/code_editing.lua")
vim.cmd("command LuaSnipEdit execute 'vsplit | edit ~/.config/nvim/snippets/' . expand('%:e') . '.lua'")
