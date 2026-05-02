return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			backends = { "treesitter", "lsp" },
			layout = {
				default_direction = "prefer_right",
				max_width = { 40, 0.2 },
				min_width = 10,
			},
			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Method",
				"Module",
				"Struct",
			},
			autojump = true,
			highlight_on_jump = false,
			close_automatic_events = { "unfocus" },
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Previous symbol" })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Next symbol" })
			end,
		})
		vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle aerial" })
	end,
}
