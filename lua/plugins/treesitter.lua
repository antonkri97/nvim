return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  otps = {
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    ensure_installed = { "yaml", "html", "angular", "markdown" },
  },
  config = function()
    require("nvim-treesitter").setup({
      -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
    require("nvim-treesitter").install({ "yaml", "html", "angular", "markdown" })
  end,
}
