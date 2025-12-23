vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local opts = { buffer = buf, silent = true }

    local function tbuiltin(fn)
      return function()
        require("telescope.builtin")[fn]()
      end
    end

    vim.keymap.set("n", "gd", tbuiltin("lsp_definitions"), opts)
    vim.keymap.set("n", "gr", tbuiltin("lsp_references"), opts)
    vim.keymap.set("n", "gi", tbuiltin("lsp_implementations"), opts)
    vim.keymap.set("n", "gT", tbuiltin("lsp_type_definitions"), opts)

    vim.keymap.set("n", "<leader>ds", tbuiltin("lsp_document_symbols"), opts)
    vim.keymap.set("n", "<leader>ws", tbuiltin("lsp_dynamic_workspace_symbols"), opts)

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ss", function()
      require("telescope.builtin").lsp_document_symbols()
    end, { buffer = 0 })

    vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles)
    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
  end,
})
