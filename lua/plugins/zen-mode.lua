local hide_winbar_tabs = function()
  require("lualine").hide({
    place = { "tabline", "winbar" }, -- The segment this change applies to.
    unhide = false,
  })
end

return {
  "folke/zen-mode.nvim",
  config = function()
    vim.keymap.set("n", "<leader>zz", function()
      hide_winbar_tabs()
      require("zen-mode").setup({
        window = {
          width = 110,
          options = {},
        },

        -- callback when the Zen window opens
        -- this callback is just incapable of hiding lualine
        -- useless
        on_open = function()
          hide_winbar_tabs()
          vim.cmd("echo 'ZenMode opened'")
          vim.cmd("lua require('lualine').hide()")
        end,
        -- callback when the Zen window closes
        on_close = function()
          require("lualine").hide({
            -- place = { 'tabline', 'winbar' }, -- The segment this change applies to.
            unhide = true, -- whether to re-enable lualine again/
          })
          vim.cmd("echo 'ZenMode closed'")
        end,
      })
      require("zen-mode").toggle()
      vim.wo.number = true
      vim.wo.rnu = true
    end)
  end,
}
