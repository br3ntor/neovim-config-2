if vim.g.vscode then
	-- VSCode extension
	print("We in VSCode wow!")
	-- vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
else
	require("br3ntor.core")
	require("br3ntor.lazy")
	print("Welcome to br3ntor's neovim setup!")
	print("Settings and Plugins loaded!")
	-- ordinary Neovim
end
