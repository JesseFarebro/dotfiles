local plugin = require('core.pack').register_plugin
local conf = require('modules.completion.config')

plugin {
  'neovim/nvim-lspconfig',
  -- used filetype to lazyload lsp
  -- config your language filetype in here
  ft = { 'lua', 'python', 'c', 'cpp' },
  requires = 'onsails/lspkind.nvim',
  config = conf.lsp,
}

plugin {
  "SmiteshP/nvim-navic",
  requires = "neovim/nvim-lspconfig",
  config = conf.navic
}

plugin {
  'williamboman/nvim-lsp-installer',
  requires = {
    'neovim/nvim-lspconfig',
    'onsails/lspkind.nvim',
  },
  config = conf.lsp_installer,
}

plugin {
  'hrsh7th/nvim-cmp',
  event = 'BufReadPre',
  config = conf.cmp,
  requires = {
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
    { 'onsails/lspkind.nvim' },
  },
}

plugin {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  config = conf.snip
}
