return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettier" },
        -- Важно для Angular:
        htmlangular = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      -- Настройка сохранения
      format_on_save = {
        lsp_fallback = true,
        async = false, -- false предотвращает "наложение" блоков кода
        timeout_ms = 1000,
      },
    })

    -- Хоткей для ручного форматирования
    vim.keymap.set("n", "<Leader>f", function()
      require("conform").format({ lsp_fallback = true })
    end, { desc = "Format buffer" })
  end,
}
