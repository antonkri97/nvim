return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- можно убрать, если не нужны иконки
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        -- icons_enabled = false, -- 👈 минимализм
        component_separators = "",
        section_separators = "",
        globalstatus = true, -- одна строка статуса на всё окно (Neovim 0.9+)
        disabled_filetypes = {
          statusline = { "neo-tree", "NvimTree", "alpha" },
        },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" }, -- 🌿 git branch
        lualine_c = {
          {
            "filename",
            path = 1, -- относительный путь
            symbols = {
              modified = " [+]",
              readonly = " [RO]",
            },
          },
        },

        lualine_x = {
          "diagnostics",
        },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
