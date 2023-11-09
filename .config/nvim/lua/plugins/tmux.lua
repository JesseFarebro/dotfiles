return {
  {
    "aserowy/tmux.nvim",
    cond = vim.fn.executable("tmux"),
    keys = {
      -- Motion
      { "<C-h>", ':lua require"tmux".move_left()<cr>', silent = true, noremap = true, desc = "Tmux Move Left" },
      { "<C-j>", ':lua require"tmux".move_bottom()<cr>', silent = true, noremap = true, desc = "Tmux Move Bottom" },
      { "<C-k>", ':lua require"tmux".move_top()<cr>', silent = true, noremap = true, desc = "Tmux Move Top" },
      { "<C-l>", ':lua require"tmux".move_right()<cr>', silent = true, noremap = true, desc = "Tmux Move Right" },
      -- Resize
      { "<A-h>", ':lua require"tmux".resize_left()<cr>', silent = true, noremap = true, desc = "Tmux Resize Left" },
      { "<A-j>", ':lua require"tmux".resize_bottom()<cr>', silent = true, noremap = true, desc = "Tmux Resize Bottom" },
      { "<A-k>", ':lua require"tmux".resize_top()<cr>', silent = true, noremap = true, desc = "Tmux Resize Top" },
      { "<A-l>", ':lua require"tmux".resize_right()<cr>', silent = true, noremap = true, desc = "Tmux Resize Right" },
    },
    opts = {
      copy_sync = {
        enable = false,
      },
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enable_default_keybindings = false,
      },
    },
  },
  {
    "christoomey/vim-tmux-runner",
    cond = vim.fn.executable("tmux"),
    keys = {
      { "<Leader>rs", "<cmd>VtrSendCommandToRunner<CR>", silent = true, noremap = true, desc = "Send Command" },
      { "<Leader>rl", "<cmd>VtrSendLinesToRunner<CR>", silent = true, noremap = true, desc = "Send Lines" },
      { "<Leader>ro", "<cmd>VtrOpenRunner<CR>", silent = true, noremap = true, desc = "Open Runner" },
      { "<Leader>rz", "<cmd>VtrFocusRunner<CR>", silent = true, noremap = true, desc = "Focus (zoom) Runner" },
      { "<Leader>rd", "<cmd>VtrDetachRunner<CR>", silent = true, noremap = true, desc = "Detach Runner" },
      { "<Leader>ra", "<cmd>VtrAttachToPane<CR>", silent = true, noremap = true, desc = "Attach to Pane" },
      { "<Leader>rt", "<cmd>VtrClearRunner<CR>", silent = true, noremap = true, desc = "Clear Runner" },
      { "<Leader>rf", "<cmd>VtrFlushCommand<CR>", silent = true, noremap = true, desc = "Flush Command" },
      { "<Leader>rz", "<cmd>VtrSendCtrlD<CR>", silent = true, noremap = true, desc = "Send CTRL-D" },
      { "<Leader>rc", "<cmd>VtrSendCtrlC<CR>", silent = true, noremap = true, desc = "Send CTRL-C" },
      { "<Leader>rw", "<cmd>VtrKillRunner<CR>", silent = true, noremap = true, desc = "Kill Runner" },
    },
    config = function()
      vim.g.VtrStripLeadingWhitespace = false
      vim.g.VtrClearEmptyLines = false
      vim.g.VtrAppendNewline = true
    end,
  },
}
