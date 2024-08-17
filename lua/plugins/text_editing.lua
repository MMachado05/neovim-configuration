--  _______        _     ______    _ _ _   _               _   _ _          _   _
-- |__   __|      | |   |  ____|  | (_) | (_)             | \ | (_)        | | (_)
--    | | _____  _| |_  | |__   __| |_| |_ _ _ __   __ _  |  \| |_  ___ ___| |_ _  ___  ___
--    | |/ _ \ \/ / __| |  __| / _` | | __| | '_ \ / _` | | . ` | |/ __/ _ \ __| |/ _ \/ __|
--    | |  __/>  <| |_  | |___| (_| | | |_| | | | | (_| | | |\  | | (_|  __/ |_| |  __/\__ \
--    |_|\___/_/\_\\__| |______\__,_|_|\__|_|_| |_|\__, | |_| \_|_|\___\___|\__|_|\___||___/
--                                                  __/ |
--                                                 |___/
-- Plugins that make the general typing workflow nicer

return {
	{
		"tpope/vim-surround",
	},
	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup({
				keys = {
					["("] = { escape = false, close = true, pair = "()" },
					["["] = { escape = false, close = true, pair = "[]" },
					["{"] = { escape = false, close = true, pair = "{}" },

					[">"] = { escape = true, close = false, pair = "<>" },
					[")"] = { escape = true, close = false, pair = "()" },
					["]"] = { escape = true, close = false, pair = "[]" },
					["}"] = { escape = true, close = false, pair = "{}" },

					['"'] = { escape = true, close = true, pair = '""' },
					["'"] = { escape = true, close = true, pair = "''" },
					["`"] = { escape = true, close = true, pair = "``" },
				},
				options = {
					disabled_filetypes = { "text", "markdown" },
					disable_when_touch = false,
					touch_regex = "[%w(%[{]",
					pair_spaces = false,
					auto_indent = true,
					disable_command_mode = false,
				},
			})
		end,
	},
}
