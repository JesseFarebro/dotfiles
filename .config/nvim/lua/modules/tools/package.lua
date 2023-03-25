local package = require('core.pack').package
local conf = require('modules.tools.config')

package {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
  },
}

package {
  'beauwilliams/focus.nvim',
  config = function()
    require'focus'.setup{signcolumn = false}
  end,
}

package {
  'luukvbaal/stabilize.nvim',
  config = function()
    require'stabilize'.setup{}
  end,
}

package {
  'karb94/neoscroll.nvim',
  config = function()
    require'neoscroll'.setup{}
  end,
}

package {
  'folke/which-key.nvim',
  config = function()
    require'which-key'.setup{}
  end,
}

package {
  "folke/zen-mode.nvim",
  cmd = 'ZenMode',
  opts = {
    window = {
      width = 0.85,
      options = {
        signcolumn = "no",
        number = false,
        relativenumber = false,
        cursorline = false,
        cursorcolumn = false,
        foldcolumn = "0",
        list = false,
      },
    },
    plugins = {
      gitsigns = { enabled = false },
    },
    on_open = function(_)
      vim.o.cmdheight = 1
      vim.cmd 'cabbrev <buffer> q let b:quitting = 1 <bar> q'
      vim.cmd 'cabbrev <buffer> wq let b:quitting = 1 <bar> wq'
    end,
    on_close = function()
      if vim.b.quitting == 1 then
        vim.b.quitting = 0
        vim.cmd 'q'
      else
        vim.o.cmdheight = 0
      end
    end,
  }
}
