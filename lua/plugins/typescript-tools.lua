return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },

  config = function()
    require("typescript-tools").setup({
      root_dir = "/Users/krivokhizhinanton/selectel-mono-panel/",
      settings = {
        separate_diagnostic_server = false,
        publish_diagnostic_on = "insert_leave",

        tsserver_max_memory = 8192,
      },
    })
  end,
}
