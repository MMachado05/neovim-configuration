return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set('n', '<leader>us', ':UndotreeShow<CR>', {})
    vim.keymap.set('n', '<leader>uc', ':UndotreeHide<CR>', {})
    vim.keymap.set('n', '<leader>uf', ':UndotreeFocus<CR>', {})
    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_TreeVertShape = "│"
    vim.g.undotree_TreeSplitShape = "󰁜"
    vim.g.undotree_TreeReturnShape = "╮"
    vim.g.undotree_TreeNodeShape = ""
  end
}
