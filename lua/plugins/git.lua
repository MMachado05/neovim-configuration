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
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
	end,
}
