local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
  },
}

plugin { 
  'ggandor/lightspeed.nvim',
  config = conf.lightspeed,
}

plugin {
  'kylechui/nvim-surround',
  config = conf.surround
}
