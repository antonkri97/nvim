return {
  "lewis6991/gitsigns.nvim",
  config = function()
    vim.keymap.set("n", "<leader>cgb", function()
      local branch = vim.b.gitsigns_head
      if not branch or branch == "" then
        vim.notify("Not in a git repo", vim.log.levels.WARN)
        return
      end

      vim.fn.setreg("+", branch)
      print("Copied git branch: " .. branch)
    end, { desc = "Copy git branch name" })
  end,
}
