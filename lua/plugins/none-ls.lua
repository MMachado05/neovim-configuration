return {
  -- TODO: This belongs in code_editing
	"nvimtools/none-ls.nvim",
	config = function()
		local none_ls = require("null-ls")
		none_ls.setup({
			sources = {
				-- Lua
				none_ls.builtins.formatting.stylua,

				-- Java
				none_ls.builtins.formatting.google_java_format,
				none_ls.builtins.diagnostics.checkstyle.with({
					extra_args = { "-c", "/google_checks.xml" },
				}),

				-- Python
				none_ls.builtins.formatting.black,

				-- Markdown
				none_ls.builtins.formatting.mdformat,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
