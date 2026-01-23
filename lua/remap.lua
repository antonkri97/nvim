vim.g.mapleader = " "
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- resize
vim.keymap.set("n", "<C-Up>", "<C-w>+")
vim.keymap.set("n", "<C-Down>", "<C-w>-")
vim.keymap.set("n", "<C-Left>", "<C-w><")
vim.keymap.set("n", "<C-Right>", "<C-w>>")

vim.keymap.set("n", "<leader>cc", function()
  vim.fn.setreg("+", vim.fn.fnamemodify(vim.fn.expand("%:p"), ":."))
  print("Path from CWD copied")
end)

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>W", ":wa<CR>", { silent = true })

local function jump_to_po(lang)
  local word = vim.fn.expand("<cword>")
  if word == "" then
    return
  end

  -- 1. Находим корень проекта
  local dot_git = vim.fn.finddir(".git", ".;")
  local git_root = dot_git ~= "" and vim.fn.fnamemodify(dot_git, ":p:h:h") or vim.fn.getcwd()

  -- 2. Находим ближайшую i18n
  local local_i18n = vim.fn.finddir("i18n", vim.fn.expand("%:p:h") .. ";")

  local search_paths = {}
  if local_i18n ~= "" then
    table.insert(search_paths, vim.fn.fnamemodify(local_i18n, ":p"))
  end
  table.insert(search_paths, git_root)

  -- Искомый текст в .po файле выглядит так: msgid "слово"
  local search_query = string.format('msgid "%s"', word)
  local result_line = nil

  -- 3. Поиск
  for _, path in ipairs(search_paths) do
    local cmd = {
      "rg",
      "--vimgrep",
      "--max-count",
      "1",
      "--fixed-strings", -- Ищем текст как есть (без regex)
      "--line-regexp", -- Строка должна совпадать целиком
      "--glob",
      "**/" .. lang .. ".po",
      search_query,
      path,
    }

    local out = vim.fn.systemlist(cmd)
    if vim.v.shell_error == 0 and #out > 0 then
      result_line = out[1] -- Берем первую строку из списка
      break
    end
  end

  if not result_line then
    vim.notify("Ключ '" .. word .. "' не найден в " .. lang .. ".po", vim.log.levels.WARN)
    return
  end

  -- 4. Разбор результата rg (file:line:col:text)
  local file, line_str = result_line:match("^(.-):(%d+):")
  if file and line_str then
    local line_idx = tonumber(line_str)
    vim.cmd("edit " .. file)

    -- Ищем строку msgstr вниз от найденного msgid
    -- В .po файлах msgstr идет сразу после msgid (или через 1 строку с комментариями)
    for i = 0, 3 do
      local target_line = line_idx + i
      local content = vim.fn.getline(target_line)
      if content:match("^msgstr") then
        -- Находим индекс первой кавычки
        local col = content:find('"') or 0
        -- Смещаем курсор на один символ вправо, чтобы встать СРАЗУ ВНУТРИ кавычек
        vim.api.nvim_win_set_cursor(0, { target_line, col })
        vim.cmd("normal! zz")
        return
      end
    end
  end
end

vim.keymap.set("n", "gpr", function()
  jump_to_po("ru")
end, { desc = "Jump to RU msgstr" })
vim.keymap.set("n", "gpe", function()
  jump_to_po("en")
end, { desc = "Jump to EN msgstr" })

vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

vim.keymap.set("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
