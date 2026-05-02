return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.indentscope").setup({
			symbol = "│",
			options = {
				border = "both",
				indent_at_cursor = true,
				try_as_border = true,
			},
			draw = {
				delay = 50,
			},
		})

		-- Disable for certain filetypes
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "help", "terminal", "lazy", "mason", "NvimTree" },
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
