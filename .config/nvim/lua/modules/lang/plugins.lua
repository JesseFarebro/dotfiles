local plugin = require('core.pack').register_plugin
local conf = require('modules.lang.config')

plugin {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  after = 'telescope.nvim',
  config = conf.treesitter,
}

plugin {
  'nvim-treesitter/nvim-treesitter-textobjects',
  after = 'nvim-treesitter'
}

plugin {
  'lervag/vimtex',
  config = function()
    vim.g.vimtex_view_method = 'skim'
  end
}
