return {
  "tpope/vim-surround",
  config = function()
    -- Visual mode: заменить S на gs
    vim.keymap.set("x", "gs", "<Plug>VSurround", { silent = true })
  end,
}
