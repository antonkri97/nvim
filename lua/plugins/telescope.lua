return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kkharji/sqlite.lua",
    { "folke/trouble.nvim", opts = {} },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-frecency.nvim" },
    { "princejoogie/dir-telescope.nvim" },
  },
  config = function()
    local telescope = require("telescope")
    local open_with_trouble = require("trouble.sources.telescope").open
    local path_tail = require("telescope.utils").path_tail

    -- Определяем кастомный форматтер
    local custom_frecency_display = require("telescope.pickers.entry_display").create({
      separator = " ",
      items = {
        -- 1. Отображаем только имя файла (без пути)
        { width = 0.5 },
        -- 2. Отображаем остаток пути, но уже без корня проекта, т.к. он уже отсекается CWD
        { remaining = true, path_display = { "truncate" } },
      },
    })

    -- Функция, которая создает запись для Telescope frecency
    local custom_entry_maker = function(entry)
      -- Используем нашу функцию отображения
      return {
        display = function(entry)
          return custom_frecency_display(entry)
        end,
        -- ... другие поля записи (value, path, ordinal и т.д.)
        value = entry.value,
        path = entry.path,
        ordinal = entry.ordinal,
      }
    end

    telescope.setup({
      defaults = {
        path_display = { "filename_first" },
        history = {
          path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
          limit = 100,
        },
        mappings = {
          i = { ["<c-t>"] = open_with_trouble },
          n = { ["<c-t>"] = open_with_trouble },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        frecency = {
          entry_maker = custom_entry_maker,
          auto_validate = false,
          show_unindexed = false, -- Важно для монорепозитория
          db_safe_mode = false,
          default_workspace = "CWD",
          db_validate_threshold = 10,
          ignore_patterns = {
            "*.git/*",
            "*/node_modules/*",
            "*/vendor/*",
            "*/dist/*",
            "*/build/*",
            "*/.cache/*",
            "*/target/*",
          },
        },
      },
    })

    -- Загружаем расширения
    -- pcall защитит от падения, если fzf еще не скомпилирован
    pcall(telescope.load_extension, "fzf")
    telescope.load_extension("frecency")
    require("dir-telescope").setup({
      -- these are the default options set
      hidden = true,
      no_ignore = false,
      show_preview = true,
      follow_symlinks = false,
    })
    require("telescope").load_extension("dir")
  end,
  keys = {
    -- --- Frecency (Умный поиск по частоте) ---
    { "<leader>pp", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "Frecency (CWD)" },

    -- --- Основные файловые операции ---
    {
      "<leader>pf",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find files",
    },
    {
      "<C-p>",
      function()
        require("telescope.builtin").git_files()
      end,
      desc = "Git files",
    },
    {
      "<leader>fr",
      function()
        require("telescope.builtin").oldfiles()
      end,
      desc = "Recent files",
    },

    -- --- Операции поиска (Grep) ---
    {
      "<leader>ps",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end,
      desc = "Grep prompt",
    },
    {
      "<leader>tg",
      function()
        require("telescope.builtin").grep_string()
      end,
      mode = { "n", "v" },
      desc = "Grep selection/word",
    },
    {
      "<leader>py",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>"), word_match = "-w" })
      end,
      desc = "Grep current word",
    },
    {
      "<leader>/",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Live grep",
    },
    {
      "<leader>fw",
      function()
        local text = vim.fn.getreg("v")
        require("telescope.builtin").live_grep({ default_text = text })
      end,
      mode = "v",
      desc = "Live grep (selection)",
    },

    -- --- Git операции ---
    {
      "<leader>gb",
      function()
        require("telescope.builtin").git_branches()
      end,
      desc = "Git branches",
    },

    -- --- Специальные операции ---
    {
      "<leader>on",
      function()
        require("telescope.builtin").find_files({ prompt_title = "Notes", cwd = "~/obsidian-selectel" })
      end,
      desc = "Find notes",
    },
  },
}
