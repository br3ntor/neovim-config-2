return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		-- Hmm is this from luals? or from a linter?
		---@diagnostic disable: missing-fields
		configs.setup({
			ensure_installed = {
				"c",
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"vimdoc",
				"dockerfile",
				"gitignore",
				"query",
				"python",
			},

			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
		---@diagnostic enable: missing-fields
	end,
}
