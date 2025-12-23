vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.opt.relativenumber = true
  end,
})
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Buffer diagnostics" })

-- vim.cmd("colorscheme onedark")
