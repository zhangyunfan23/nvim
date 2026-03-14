return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    -- open at the current file's directory
    { "<leader>-", "<cmd>Yazi<cr>", desc = "Open yazi (current file)" },
    -- open at the project root (cwd)
    { "<leader>fy", "<cmd>Yazi cwd<cr>", desc = "Open yazi (cwd)" },
    -- resume the last yazi session — handy when jumping between experiment dirs
    { "<C-Up>", "<cmd>Yazi toggle<cr>", desc = "Resume last yazi session" },
  },
  opts = {
    -- open yazi instead of netrw when vim is launched on a directory
    open_for_directories = true,

    floating_window_scaling_factor = 0.9,

    -- keep the terminal background transparent so your colorscheme shows through
    yazi_floating_window_winblend = 0,

    -- AI researcher tweaks: use a wide float to see long file names (checkpoints, runs)
    yazi_floating_window_border = "rounded",

    keymaps = {
      show_help = "<f1>",
      open_file_in_vertical_split = "<c-v>",
      open_file_in_horizontal_split = "<c-x>",
      open_file_in_tab = "<c-t>",
      -- send selected files to the quickfix list for batch operations
      send_to_quickfix_list = "<c-q>",
      -- cycle through yazi's open buffers inside the float
      change_working_directory = "<c-\\>",
    },

    -- highlight yanked files — useful when copying dataset / checkpoint paths
    highlight_groups = {
      hovered_buffer = nil,
    },

    integrations = {
      -- grep inside the directory yazi is currently showing
      grep_in_directory = function(directory)
        require("fzf-lua").live_grep({ cwd = directory })
      end,
      -- find files inside the directory yazi is currently showing
      grep_in_selected_files = function(paths)
        require("fzf-lua").live_grep({ file_list = paths })
      end,
    },
  },
}
