local package = require('core.pack').package
local conf = require('modules.ui.config')

package {
  'folke/tokyonight.nvim',
  config = conf.tokyonight,
  priority = 1000,
}

package {
  'nvim-tree/nvim-tree.lua',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = conf.tree,
}

package {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufRead',
  dependencies = {
    'nvim-treesitter',
    'tokyonight.nvim',
  },
  priority = 950,
  opts = {
    char = "│",
    space_char = "·",
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    show_current_context_start_on_current_line = false,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    buftype_exclude = {"help", "terminal"},
    filetype_exclude = {"text", "nofile", "prompt", "terminal", "markdown", "NvimTree", "TelescopePrompt"},
    context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'},
    use_treesitter = true
  }
}

package {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'SmiteshP/nvim-navic'
  },
  priority = 1000,
  opts = {
    options = {
      theme = 'tokyonight',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        'filename',
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          color_error = '#e06c75',
          color_warn = '#e5c07b',
          color_info = '#56b6c2',
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' '
          }
        }
      },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location'  },
    },
    extensions = { 'nvim-tree' }
  }
}

package {
  'utilyre/barbecue.nvim',
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  priority = 900,
  opts = {
    theme = 'tokyonight',
    exclude_filetypes = { "gitcommit", "toggleterm", "NvimTree" }
  }
}
