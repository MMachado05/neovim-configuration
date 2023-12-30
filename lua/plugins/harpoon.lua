return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon.setup({})


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
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
        vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)

		vim.keymap.set("n", "<leader>hq", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<leader>hw", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<leader>he", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<leader>hr", function() harpoon:list():select(4) end)

		vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end)

		vim.keymap.set("n", "<leader>hdq", function() harpoon:list():removeAt(1) end)
		vim.keymap.set("n", "<leader>hdw", function() harpoon:list():removeAt(2) end)
		vim.keymap.set("n", "<leader>hde", function() harpoon:list():removeAt(3) end)
		vim.keymap.set("n", "<leader>hdr", function() harpoon:list():removeAt(4) end)

	end,
}
