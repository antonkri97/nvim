local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'telescope find files' })
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end)
require("telescope").setup({
	defaults = {
		path_display = { "smart" },
		history = {
			path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
			limit = 100,
		},
	},
})
vim.keymap.set({'n', 'v'}, "<leader>tg", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", {
  desc = "Git branches",
})
vim.keymap.set("n", "<leader>py", function()
  local yank = vim.fn.getreg('"')
  require("telescope.builtin").grep_string({
    search = yank,
    word_match = "-w",
  })
end, { desc = "Grep last yank" })

