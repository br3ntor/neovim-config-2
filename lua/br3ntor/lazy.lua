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

--require("lazy").setup({ { import = "br3ntor.plugins" }, { import = "br3ntor.plugins.lsp" } })

-- require("lazy").setup(plugins, opts)
require("lazy").setup({
  { import = "br3ntor.plugins" },
  { import = "br3ntor.plugins.lsp" },

  -- Not sure if I need/want this - neodev...synergizes with folke/neoconf?
  "folke/neodev.nvim",


  -- Not sure if I want these, look into them later
  -- { "folke/neoconf.nvim", cmd = "Neoconf" },

})
