return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Используем eslint_d (демон) для скорости
        require("none-ls.diagnostics.eslint_d"),
      },
      -- Форматирование здесь БОЛЬШЕ НЕ НУЖНО, его делает conform
    })
  end,
}
