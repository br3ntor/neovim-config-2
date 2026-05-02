-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- use jk to exit insert mode
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Open netrw, the vim file explorer
-- Hmmm I don't know which way I prefer
-- keymap.set("n", "<leader>e", vim.cmd.Explore)
-- keymap.set("n", "<leader>e", ":Explore<CR>")
-- Got sick/frustrated with netrw so nvim-tree now
keymap.set("n", "<leader>e", ":NvimTreeOpen<CR>", { desc = "Open file tree" })

-- Buffer controls
keymap.set("n", "<leader>b", "<cmd>buffers<CR>:buffer<Space>", { desc = "Open buffers and prompt choice" })
keymap.set("n", "<leader>p", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>n", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>q", ":bdelete<CR>", { desc = "Delete buffer" })

-- These are for bufferline plugin, trying all natural atm
--vim.keymap.set('n', '<leader>p', ':BufferLineCyclePrev<CR>', {})
--vim.keymap.set('n', '<leader>n', ':BufferLineCycleNext<CR>', {})

-- Remap Esc to leave terminal
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Function to close all buffers except the current one
local function close_other_buffers()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

-- Key mapping to call the function
keymap.set("n", "<leader>bd", close_other_buffers, { desc = "Close other buffers" })
