local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin { 
  'ggandor/lightspeed.nvim',
  config = conf.lightspeed,
  disable = false,
}

plugin {
  'kylechui/nvim-surround',
  config = conf.surround,
  disable = false,
}

plugin {
  'numToStr/Comment.nvim',
  config = function()
      require('Comment').setup()
  end,
  disable = false,
}
