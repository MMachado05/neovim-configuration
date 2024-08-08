--  _____  _           _                               _   _    ___   __
-- |  __ \(_)         | |                             | | | |  | \ \ / /
-- | |  | |_ ___ _ __ | | __ _ _   _    __ _ _ __   __| | | |  | |\ V /
-- | |  | | / __| '_ \| |/ _` | | | |  / _` | '_ \ / _` | | |  | | > <
-- | |__| | \__ \ |_) | | (_| | |_| | | (_| | | | | (_| | | |__| |/ . \
-- |_____/|_|___/ .__/|_|\__,_|\__, |  \__,_|_| |_|\__,_|  \____//_/ \_\
--              | |             __/ |
--              |_|            |___/
-- Plugins relating to how the neovim viewport looks and behaves
return {
	-- --------------------
	-- Status Bars and Such
	-- --------------------
	{
		-- Might honestly get rid of this as soon as I've got a good buffer workflow
		"romgrk/barbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
				},
				sections = {
					lualine_x = { "hostname", "encoding", "fileformat", "filetype" },
				},
			})
		end,
	},

	-- -------------------
	-- Specialized windows
	-- -------------------
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>nol", ":Neotree filesystem reveal left<CR>", {})
			vim.keymap.set("n", "<leader>nor", ":Neotree filesystem reveal right<CR>", {})
			vim.keymap.set("n", "<leader>ntl", ":Neotree filesystem toggle left<CR>", {})
			vim.keymap.set("n", "<leader>ntr", ":Neotree filesystem toggle right<CR>", {})
		end,
	},
	{
    -- For previewing images and viewing them in Neovim
		"edluffy/hologram.nvim",
		-- This won't work until I switch to using Kitty and have installed ImageMagick.
		--  I also want 3rd/image.nvim for Neotree image previewing, so I'll have to look int
		--  that again.
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>us", ":UndotreeShow<CR>", {})
			vim.keymap.set("n", "<leader>uc", ":UndotreeHide<CR>", {})
			vim.keymap.set("n", "<leader>uf", ":UndotreeFocus<CR>", {})
			vim.g.undotree_WindowLayout = 3
			vim.g.undotree_TreeVertShape = "│"
			vim.g.undotree_TreeSplitShape = "󰁜"
			vim.g.undotree_TreeReturnShape = "╮"
			vim.g.undotree_TreeNodeShape = ""
		end,
	},

	-- ---------------
	-- Visual Elements
	-- ---------------
	{
		"folke/twilight.nvim",
		config = function()
			vim.keymap.set("n", "<leader>te", ":TwilightEnable<CR>")
			vim.keymap.set("n", "<leader>td", ":TwilightDisable<CR>")
		end,
	},
}
