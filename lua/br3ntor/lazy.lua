local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	-- neoconf.nvim is a Neovim plugin to manage global and project-local settings.
	-- Haven't wanted these yet but could be nice later on
	-- { "folke/neoconf.nvim", cmd = "Neoconf" },

	{ import = "br3ntor.plugins" },
	{ import = "br3ntor.plugins.lsp" },
})
