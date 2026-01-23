vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "htmlangular" },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt.showmode = false
  end,
})

vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = { "html", "xhtml" }, -- Adjust patterns as needed
  callback = function()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})

vim.opt.foldenable = false

vim.keymap.set("n", "<leader>kt", "<cmd>Telescope colorscheme<cr>")
vim.keymap.set("n", "<leader>hs", function()
  require("lualine").hide({
    place = { "tabline", "winbar" }, -- The segment this change applies to.
    unhide = false,
  })
end)

-- Принудительно связываем все вариации с одним парсером
vim.treesitter.language.register("angular", "angularhtml")

vim.api.nvim_create_user_command("I18n", function()
  vim.cmd('split | term zsh -ic "i18n"')
end, {})
