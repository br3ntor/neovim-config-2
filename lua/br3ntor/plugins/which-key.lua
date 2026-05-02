return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
  end,
  opts = {
    preset = "modern",
    win = { border = "single" },
  }
}
