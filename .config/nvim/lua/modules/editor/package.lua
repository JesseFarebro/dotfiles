local package = require('core.pack').package
local conf = require('modules.editor.config')

package {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  build = ':TSUpdate',
  config = conf.treesitter,
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }
}

package { 
  'ggandor/lightspeed.nvim',
  config = conf.lightspeed,
}

package {
  'kylechui/nvim-surround',
}

package {
  'numToStr/Comment.nvim',
  config = function()
      require('Comment').setup()
  end,
}
