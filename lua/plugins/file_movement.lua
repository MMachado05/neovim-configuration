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
	-- --------------------------------
	-- Oil for the RC thing or whatever
	-- --------------------------------
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
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope_builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
    end
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

	-- -------
	-- Harpoon
	-- -------
	-- TODO: Change this to arrow?
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local harpoon = require("harpoon")
			harpoon.setup({})

			-- Allow Harpoon to use Telescope
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			-- Harpoon functionality keymaps
			vim.keymap.set("n", "<leader>ho", function()
				toggle_telescope(harpoon:list())
			end, { desc = "Open harpoon window" })
			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():append()
			end)
			vim.keymap.set("n", "<leader>hp", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list():next()
			end)

			vim.keymap.set("n", "<leader>hq", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>hw", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>he", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>hr", function()
				harpoon:list():select(4)
			end)

			vim.keymap.set("n", "<leader>hc", function()
				harpoon:list():clear()
			end)

			vim.keymap.set("n", "<leader>hdq", function()
				harpoon:list():removeAt(1)
			end)
			vim.keymap.set("n", "<leader>hdw", function()
				harpoon:list():removeAt(2)
			end)
			vim.keymap.set("n", "<leader>hde", function()
				harpoon:list():removeAt(3)
			end)
			vim.keymap.set("n", "<leader>hdr", function()
				harpoon:list():removeAt(4)
			end)
		end,
	},
}
