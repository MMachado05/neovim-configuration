--  _____ _ _     _____                              _
-- |  __ (_) |   /  ___|                            | |
-- | |  \/_| |_  \ `--. _   _ _ __  _ __   ___  _ __| |_
-- | | __| | __|  `--. \ | | | '_ \| '_ \ / _ \| '__| __|
-- | |_\ \ | |_  /\__/ / |_| | |_) | |_) | (_) | |  | |_
--  \____/_|\__| \____/ \__,_| .__/| .__/ \___/|_|   \__|
--                           | |   | |
--                           |_|   |_|
-- Plugins that allow neovim to understand Git projects

return {
	{
		-- Gitsigns for visual git elements
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	-- {
	-- 	-- Toggleterm to set up integrated Lazygit
	-- 	"akinsho/toggleterm.nvim",
	-- 	version = "v1.*",
	-- 	opts = {},
	-- 	config = function()
	-- 		require("toggleterm").setup({
	-- 			direction = "float",
	-- 		})
	-- 	end,
	-- }, NOTE: See keybinds.lua for why this is commented out.
}
