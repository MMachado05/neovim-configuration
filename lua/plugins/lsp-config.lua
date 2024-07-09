return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"jdtls",
					"pyright",
					"lemminx",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup all LSPs in "ensure_installed"
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.lemminx.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			vim.diagnostic.config({
				underline = true, -- this is already set by default
				-- other options
			})

			vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.cmd("command AddLsp vsplit | edit ~/.config/nvim/lua/plugins/lsp-config.lua")
		end,
	},
	-- {
	--   "mfussenegger/nvim-jdtls",
	--   config = function()
	--     local function get_libs(project_root)
	--       local find_jar_libs_cmd = "find " .. project_root .. "/libs -type f | grep jar"
	--       local extract_classpathentries_cmd = "grep 'classpathentry kind=\"lib\"' "
	--           .. project_root
	--           .. "/.classpath | sed 's/.*classpathentry kind=\"lib\" path=\"//' | sed 's/\".*//'"
	--
	--       if vim.fn.filereadable(project_root .. "/.classpath") == 1 then
	--         local libs = require("config.helper").cmd_to_table(extract_classpathentries_cmd)
	--
	--         local new_table = {}
	--         for _, lib in ipairs(libs) do
	--           table.insert(new_table, project_root .. "/" .. lib)
	--         end
	--         return new_table
	--       end
	--
	--       return require("config.helper").cmd_to_table(find_jar_libs_cmd)
	--     end
	--
	--     local config = {
	--       cmd = { "/home/marcialalfonso/.local/share/nvim/mason/packages/jdtls/jdtls" },
	--       root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
	--
	--       settings = {
	--         java = {
	--           project = {
	--             referencedLibraries = get_libs(root_dir),
	--           },
	--         },
	--       },
	--     }
	--     require("jdtls").start_or_attach(config)
	--   end,
	-- },
}
