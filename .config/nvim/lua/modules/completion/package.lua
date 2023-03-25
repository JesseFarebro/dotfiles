local package = require('core.pack').package
local conf = require('modules.completion.config')

package {
  'neovim/nvim-lspconfig',
  -- used filetype to lazyload lsp
  -- config your language filetype in here
  ft = { 'lua', 'python', 'c', 'cpp', 'tex' },
  dependencies = {
    'onsails/lspkind.nvim',
    'williamboman/mason-lspconfig.nvim',
    'SmiteshP/nvim-navic',
  },
  config = conf.lsp,
}

package {
  "SmiteshP/nvim-navic",
  dependencies = "neovim/nvim-lspconfig",
}

package {
  'williamboman/mason.nvim',
  config = function()
    require('mason').setup{}
  end,
}

package {
  'glepnir/lspsaga.nvim',
  event = 'BufRead',
}

package {
  'hrsh7th/nvim-cmp',
  event = 'BufReadPre',
  config = conf.cmp,
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'onsails/lspkind.nvim' },
  },
}

package {
  'github/copilot.vim',
  event = 'BufReadPre',
}

package {
  'L3MON4D3/LuaSnip',
  event = 'InsertCharPre',
  config = conf.snip
}
