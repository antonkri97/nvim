return {
  "tpope/vim-fugitive",
  config = function()
    local map = vim.keymap.set

    map("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
    map("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
    map("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
    map("n", "<leader>gl", ":Git log --oneline<CR>", { desc = "Git log" })
    map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
  end,
}
