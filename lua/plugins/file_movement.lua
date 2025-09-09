-- ______ _ _        _   _             _             _   _
-- |  ___(_) |      | \ | |           (_)           | | (_)
-- | |_   _| | ___  |  \| | __ ___   ___  __ _  __ _| |_ _  ___  _ __
-- |  _| | | |/ _ \ | . ` |/ _` \ \ / / |/ _` |/ _` | __| |/ _ \| '_ \
-- | |   | | |  __/ | |\  | (_| |\ V /| | (_| | (_| | |_| | (_) | | | |
-- \_|   |_|_|\___| \_| \_/\__,_| \_/ |_|\__, |\__,_|\__|_|\___/|_| |_|
--                                        __/ |
--                                       |___/
-- How I move through files on my filesystem, or files open as buffers

return {
	-- -------------
	-- Oil for netrw
	-- -------------
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- ---------
	-- Telescope
	-- ---------
	-- TODO: I need to get rid of all dependencies. I think it'd just be better if I
	--  had each one explicitly, in case I need to make config changes in the future.
	{
		"nvim-telescope/telescope.nvim",
		-- branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		-- Sets the Telescope UI to everything relating to selection
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		-- File browser with Telescope
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local command = "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ hidden = true })<CR>"
			vim.keymap.set("n", "<leader>fs", command, { noremap = true })
		end,
	},

	-- ---------------------
	-- Arrow for bookmarking
	-- ---------------------
	{
		"otavioschwanck/arrow.nvim",
		opts = {
			show_icons = true,
			leader_key = ";", -- Recommended to be a single key
			buffer_leader_key = "m", -- Per Buffer Mappings
		},
	},
}
