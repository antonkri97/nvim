return {
  "nvim-telescope/telescope-frecency.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "kkharji/sqlite.lua",
  },
  config = function()
    require("telescope").load_extension("frecency")

    vim.keymap.set("n", "<leader>pp", ":Telescope frecency workspace=CWD<CR>", {})
  end,
  -- keys = {
  -- 	{ "<leader>f", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "Frecency" }
  -- },
  opts = {
    auto_validate = true,
    show_unindexed = true,
    default_workspace = "CWD",
    -- show_scores = false,
    -- show_unindexed = true,
    ignore_patterns = {
      "*.git/*",
      "*/tmp/*",
      "*/node_modules/*",
      "*/vendor/*",
      "*/.cache/*",
      "*/build/*",
      "*/dist/*",
      "*/__pycache__/*",
    },
    -- workspaces = {
    -- 	["conf"] = vim.fn.expand("~/.config"),
    -- 	["project"] = vim.fn.expand("~/projects"),
    -- },
    -- Ограничить количество результатов для скорости
    -- max_timestamps = 10,
  },
}
