local command = "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ hidden = true })<CR>"
return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
        vim.keymap.set('n', '<leader>fb', command, { noremap = true })
    end
}
