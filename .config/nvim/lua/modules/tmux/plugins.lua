local plugin = require('core.pack').register_plugin
local conf = require('modules.tmux.config')

plugin {
  'aserowy/tmux.nvim',
  opt = true,
  cond = vim.fn.executable('tmux'),
  config = conf.tmux,
}

plugin {
  'christoomey/vim-tmux-runner',
  opt = true,
  cond = vim.fn.executable('tmux'),
  config = conf.runner,
}
