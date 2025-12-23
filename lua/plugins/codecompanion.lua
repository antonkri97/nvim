return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim", -- Рекомендуется для интерфейса выбора
  },
  opts = {
    adapters = {
      http = {
        -- Создаем адаптер специально под Selectel
        selectel = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://ai.selectel.org/api",
              api_key = os.getenv("SELECTEL_API_KEY"), -- Замените на ваш реальный ключ или os.getenv("SELECTEL_API_KEY")
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "qwen3-235b-a22b-fp8-instruct",
              },
            },
          })
        end,
      },
    },
    interactions = {
      -- Устанавливаем Selectel как основной адаптер для всех функций
      chat = {
        adapter = "selectel",
      },
      inline = {
        adapter = "selectel",
      },
      agent = {
        adapter = "selectel",
      },
    },
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to AI Chat" },
  },
}
