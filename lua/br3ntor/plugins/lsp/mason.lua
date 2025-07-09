return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"jsonls",
				"clangd",
				"bashls",
				"eslint",
				"gopls",
				"sqls",
			},
			automatic_enable = false,
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"ruff",
				"shellcheck",
				"sql-formatter",
				"clang-format",
			},
		})
	end,
}
