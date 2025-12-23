return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- иконки
    "MunifTanjim/nui.nvim",
  },

  cmd = "Neotree", -- lazy-load по команде
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
    { "<leader>o", "<cmd>Neotree focus<CR>",  desc = "Focus NeoTree" },
  },

  opts = {
    close_if_last_window = true,

    window = {
      position = "left",
      width = 32,

      mappings = {
        ["<CR>"] = "open",
        ["l"]    = "open",
        ["h"]    = "close_node",

        ["s"] = "open_vsplit",
        ["S"] = "open_split",
        ["t"] = "open_tabnew",

        ["a"] = "add",
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["c"] = "copy",
        ["m"] = "move",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",

        ["<bs>"] = "navigate_up",
        ["."]    = "set_root",

        ["H"] = "toggle_hidden",
        ["R"] = "refresh",

        ["?"] = "show_help",
        ["q"] = "close_window",
      },
    },

    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
    },

    buffers = {
      follow_current_file = {
        enabled = true,
      },
    },

    git_status = {
      window = {
        position = "float",
      },
    },
  },
}

