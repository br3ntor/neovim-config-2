return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
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
			"query",
			"python",
			"go",
		}

		-- Optional: configure install directory (uses default if omitted)
		require("nvim-treesitter").setup()

		-- Install parsers (async by default)
		local installed = {}
		pcall(function()
			installed = require("nvim-treesitter").get_installed and
				require("nvim-treesitter").get_installed() or {}
		end)

		local to_install = {}
		for _, p in ipairs(parsers) do
			if not vim.tbl_contains(installed, p) then
				table.insert(to_install, p)
			end
		end

		if #to_install > 0 then
			require("nvim-treesitter").install(to_install)
		end

		-- Enable treesitter highlighting and indentation per filetype
		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
