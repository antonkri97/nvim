local prettier = require("prettier")

prettier.setup({
  bin = "prettier", -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  -- Интеграция с none-ls через CLI
  cli_options = {
    arrow_parens = "always",
    bracket_spacing = true,
    end_of_line = "lf",
    print_width = 80,
    semi = true,
    single_quote = false,
    tab_width = 2,
    trailing_comma = "es5",
  },
})
