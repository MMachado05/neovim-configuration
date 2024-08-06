return {
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
}
