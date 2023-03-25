local package = require('core.pack').package
local conf = require('modules.tmux.config')

package {
  'aserowy/tmux.nvim',
  lazy = true,
  cond = vim.fn.executable('tmux'),
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
  lazy = true,
  cond = vim.fn.executable('tmux'),
  config = conf.runner,
}
