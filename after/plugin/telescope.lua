local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "telescope find files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "telescope find files" })
vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add_to_trouble

require("telescope").setup({
  defaults = {
    path_display = { "smart" },
    history = {
      path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
      limit = 100,
    },
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})
vim.keymap.set({ "n", "v" }, "<leader>tg", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", {
  desc = "Git branches",
})
vim.keymap.set("n", "<leader>py", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").grep_string({
    search = word,
    word_match = "-w",
  })
end, { desc = "Grep last yank" })

vim.keymap.set("n", "<leader>on", function()
  require("telescope.builtin").find_files({
    prompt_title = "Notes",
    cwd = "~/obsidian-selectel",
  })
end)
