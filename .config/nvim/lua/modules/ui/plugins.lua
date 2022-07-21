local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

plugin {
  'folke/tokyonight.nvim',
  config = conf.tokyonight
}

plugin {
  "folke/zen-mode.nvim",
  config = conf.zen,
  cmd = 'ZenMode'
}

plugin {
  'beauwilliams/focus.nvim',
  config = function()
    require'focus'.setup{}
  end
}

plugin {
  'folke/which-key.nvim',
  config = function()
    require'which-key'.setup{}
  end
}

plugin {
  'luukvbaal/stabilize.nvim',
  config = function()
    require'stabilize'.setup{}
  end
}

plugin {
  'karb94/neoscroll.nvim',
  config = function()
    require'neoscroll'.setup{}
  end
}

plugin {
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = conf.tree
}

plugin {
  'lukas-reineke/indent-blankline.nvim',
  config = conf.indent,
  after = {
    'nvim-treesitter',
    'tokyonight.nvim',
  }
}

plugin {
  'nvim-lualine/lualine.nvim',
  config = conf.lualine,
  requires = {
    'kyazdani42/nvim-web-devicons',
    'SmiteshP/nvim-navic'
  }
}

plugin {
  'akinsho/nvim-bufferline.lua',
  config = conf.bufferline,
  requires = 'kyazdani42/nvim-web-devicons'
}
