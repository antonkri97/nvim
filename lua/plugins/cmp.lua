return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP source
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip", -- snippets engine
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
    vim.keymap.set({ "i" }, "<C-K>", function()
      luasnip.expand()
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-L>", function()
      luasnip.jump(1)
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-J>", function()
      luasnip.jump(-1)
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-E>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true })

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        format = function(entry, vim_item)
          -- Используем detail (стандартное поле LSP для описания/типа)
          if entry.completion_item and entry.completion_item.detail then
            vim_item.menu = entry.completion_item.detail
          -- Fallback на имя источника, если детали нет
          else
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name] or ""
          end
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(), -- вызвать вручную
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      }),

      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
    })
  end,
}
