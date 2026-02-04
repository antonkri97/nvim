return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local util = require("lspconfig.util")

    -- vim.lsp.config("angularls", {
    --   cmd = function(dispatchers, config)
    --     local bufname = vim.api.nvim_buf_get_name(0)
    --     local root_dir = util.root_pattern("tsconfig.json", "tsconfig.app.json", "angular.json")
    --     print(root_dir(bufname))
    --
    --     local cmd = {
    --       "node",
    --       "--max-old-space-size=16384",
    --       "/Users/krivokhizhinanton/.n/bin/ngserver",
    --       "--stdio",
    --       "--tsProbeLocations",
    --       "/Users/krivokhizhinanton/selectel-mono-panel/node_modules/typescript/lib",
    --       "--ngProbeLocations",
    --       "/Users/krivokhizhinanton/.n/lib/node_modules/@angular/language-server",
    --       "--project",
    --       "packages/dedicated-panel/tsconfig.json",
    --     }
    --
    --     return vim.lsp.rpc.start(cmd, dispatchers)
    --   end,
    -- })

    -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

    --Enable (broadcasting) snippet capability for completion
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- 1. Сначала определяем общие возможности (capabilities)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.config("angularls", {
      cmd = function(dispatchers, config)
        local cmd = {
          "node",
          "--max-old-space-size=8192",
          "/Users/krivokhizhinanton/.n/bin/ngserver",
          "--stdio",
          "--tsProbeLocations",
          "/Users/krivokhizhinanton/selectel-mono-panel/node_modules/typescript/lib",
          "--ngProbeLocations",
          "/Users/krivokhizhinanton/.n/lib/node_modules/@angular/language-server",
          "--angularCoreVersion",
          "19.2.14",
        }
        return vim.lsp.rpc.start(cmd, dispatchers)
      end,

      -- Убран "typescript" — его обрабатывает typescript-tools
      -- Angular LSP теперь только для шаблонов
      -- filetypes = { "html", "htmlangular" },
      root_markers = { "angular.json", "nx.json" },
    })
    vim.lsp.config("cssls", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    -- Find Angular project root
    vim.lsp.enable("angularls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("cssls")
  end,
}
