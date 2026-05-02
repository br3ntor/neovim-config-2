return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
		vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Grep string under cursor" })
		vim.keymap.set("n", "<leader>fw", function()
			local word = vim.fn.expand("<cword>")
			require("telescope.builtin").live_grep({ default_text = word })
		end, { desc = "Live grep for word under cursor" })
	end,
}
