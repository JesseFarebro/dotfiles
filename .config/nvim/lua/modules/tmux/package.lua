local package = require('core.pack').package
local keymap = require('core.keymap')
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

if vim.g.vscode ~= nil then
  return
end

package {
  'aserowy/tmux.nvim',
  cond = vim.fn.executable('tmux'),
  keys = {
    -- Motion
    { '<C-h>', ':lua require"tmux".move_left()<cr>', opts(noremap, silent), desc = 'Tmux Move Left' },
    { '<C-j>', ':lua require"tmux".move_bottom()<cr>', opts(noremap, silent), desc = 'Tmux Move Bottom' },
    { '<C-k>', ':lua require"tmux".move_top()<cr>', opts(noremap, silent), desc = 'Tmux Move Top' },
    { '<C-l>', ':lua require"tmux".move_right()<cr>', opts(noremap, silent), desc = 'Tmux Move Right' },
    -- Resize
    { '<A-h>', ':lua require"tmux".resize_left()<cr>', opts(noremap, silent), desc = 'Tmux Resize Left' },
    { '<A-j>', ':lua require"tmux".resize_bottom()<cr>', opts(noremap, silent), desc = 'Tmux Resize Bottom' },
    { '<A-k>', ':lua require"tmux".resize_top()<cr>', opts(noremap, silent), desc = 'Tmux Resize Top' },
    { '<A-l>', ':lua require"tmux".resize_right()<cr>', opts(noremap, silent), desc = 'Tmux Resize Right' },
  },
  opts = {
    copy_sync = {
      enable = false
    },
    navigation = {
      enable_default_keybindings = false
    },
    resize = {
      enable_default_keybindings = false
    }
  }
}

package {
  'christoomey/vim-tmux-runner',
  cond = vim.fn.executable('tmux'),
  keys = {
    { '<Leader>sc', cmd('VtrSendCommandToRunner'), opts(noremap, silent), desc = 'Send Command' },
    { '<Leader>sl', cmd('VtrSendLinesToRunner'), opts(noremap, silent), desc = 'Send Lines' },
    { '<Leader>or', cmd('VtrOpenRunner'), opts(noremap, silent), desc = 'Open Runner' },
    { '<Leader>fr', cmd('VtrFocusRunner'), opts(noremap, silent), desc = 'Focus Runner' },
    { '<Leader>dr', cmd('VtrDetachRunner'), opts(noremap, silent), desc = 'Detach Runner' },
    { '<Leader>ar', cmd('VtrAttachToPane'), opts(noremap, silent), desc = 'Attach to Pane' },
    { '<Leader>cr', cmd('VtrClearRunner'), opts(noremap, silent), desc = 'Clear Runner' },
    { '<Leader>fc', cmd('VtrFlushCommand'), opts(noremap, silent), desc = 'Flush Command' },
    { '<Leader>scd', cmd('VtrSendCtrlD'), opts(noremap, silent), desc = 'Send CTRL-D' },
    { '<Leader>scc', cmd('VtrSendCtrlC'), opts(noremap, silent), desc = 'Send CTRL-C' },
    { '<Leader>kr', cmd('VtrKillRunner'), opts(noremap, silent), desc = 'Kill Runner' },
  },
  config = function()
    vim.g.VtrStripLeadingWhitespace = false
    vim.g.VtrClearEmptyLines = false
    vim.g.VtrAppendNewline = true
  end
}
