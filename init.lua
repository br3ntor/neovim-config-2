if vim.g.vscode then
	-- VSCode extension
	print("Started Neovim in VSCode!")
	-- vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
else
	-- ordinary Neovim
	require("br3ntor.core")
	require("br3ntor.lazy")
	-- print("Welcome to br3ntor's neovim setup!")
	-- print("Settings and Plugins loaded!")
end
