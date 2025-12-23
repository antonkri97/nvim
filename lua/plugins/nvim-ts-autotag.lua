return {
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- lazy loading по событиям не обязателен, но можно:
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
        -- индивидуальные настройки по языкам (опционально)
        per_filetype = {
          -- ['html'] = { enable_close = false },
        },
      })
    end,
  },
}
