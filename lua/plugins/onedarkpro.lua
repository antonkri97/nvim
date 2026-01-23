return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    -- vim.cmd("colorscheme onelight")
    -- vim.cmd("colorscheme onedark")
    vim.cmd("colorscheme onedark_dark")
  end,
}
