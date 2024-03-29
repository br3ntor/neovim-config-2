-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Open netrw, the vim file explorer
-- Hmmm I don't know which way I prefer
-- keymap.set("n", "<leader>e", vim.cmd.Explore)
keymap.set("n", "<leader>e", ":Explore<CR>")

-- Buffer controls
keymap.set("n", "<leader>b", "<cmd>buffers<CR>:buffer<Space>", { desc = "Open buffers and prompt choice" })
keymap.set("n", "<leader>p", ":bprevious<CR>", {})
keymap.set("n", "<leader>n", ":bnext<CR>", {})
keymap.set("n", "<leader>q", ":bdelete<CR>", {})

-- These are for bufferline plugin, trying all natural atm
--vim.keymap.set('n', '<leader>p', ':BufferLineCyclePrev<CR>', {})
--vim.keymap.set('n', '<leader>n', ':BufferLineCycleNext<CR>', {})

-- Remap Esc to leave terminal
keymap.set("t", "<Esc>", "<C-\\><C-n>", {})
