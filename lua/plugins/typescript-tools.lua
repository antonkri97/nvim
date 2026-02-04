return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local api = require("typescript-tools.api")
    local tt_utils = require("typescript-tools.utils")

    -- ПЕРЕОПРЕДЕЛЯЕМ функцию поиска корня глобально для плагина,
    -- так как setup затирает то, что мы передаем в config.root_dir
    tt_utils.get_root_dir = function(bufnr)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local root = vim.fs.find({ "tsconfig.nvim.json" }, { path = fname, upward = true })[1]
      if root then
        return vim.fs.dirname(root)
      end
      -- Фоллбек на стандартный поиск плагина
      return vim.fs.dirname(vim.fs.find({ "tsconfig.json", "package.json" }, { path = fname, upward = true })[1])
    end

    require("typescript-tools").setup({
      -- Прямые настройки tsserver (без функций, только статика)
      settings = {
        tsserver_max_memory = 8192,
        separate_diagnostic_server = true,
        -- В этой версии плагина кастомные флаги передаются так:
        tsserver_args = {
          -- ВАЖНО: Мы не можем динамически менять это здесь для каждого файла,
          -- поэтому используем флаг поиска конкретного имени файла
          "--project",
          "tsconfig.nvim.json",
        },
      },
      -- Прочие стандартные опции LSP
      on_attach = function(client, bufnr)
        -- Проверка: если tsserver не нашел конфиг, он может упасть.
        -- Если LSP не стартует, попробуй закомментировать tsserver_args выше.
      end,
    })
    vim.keymap.set(
      "n",
      "<leader>ai",
      "<cmd>TSToolsAddMissingImports<cr>",
      { buffer = bufnr, desc = "TS: Add missing imports" }
    )
  end,
}
