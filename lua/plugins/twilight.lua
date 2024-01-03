return {
	"folke/twilight.nvim",
  config = function()
    vim.keymap.set('n', '<leader>te', ':TwilightEnable<CR>')
    vim.keymap.set('n', '<leader>td', ':TwilightDisable<CR>')
  end
}
