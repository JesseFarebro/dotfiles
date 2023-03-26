local package = require('core.pack').package
local keymap = require('core.keymap')

local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

if vim.g.vscode ~= nil then
  return
end

package {
  'folke/tokyonight.nvim',
  priority = 1000,
  opts = {
    style = 'storm',
    transparent = true,
    styles = {
      functions = { italic = true },
      sidebars = "transparent",
      floats = "transparent",
    },
    sidebars = { 'packer', 'nvim_tree', 'NvimTree', 'netrw' },
    hide_inactive_statusline = true,
    dim_inactive = true,
    on_highlights = function(hl, c)
      local prompt = "#2d3149"
      hl.TelescopeNormal = {
        bg = c.bg_dark,
        fg = c.fg_dark,
      }
      hl.TelescopeBorder = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopePromptNormal = {
        bg = prompt,
      }
      hl.TelescopePromptBorder = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePromptTitle = {
        bg = prompt,
        fg = prompt,
      }
      hl.TelescopePreviewTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
      hl.TelescopeResultsTitle = {
        bg = c.bg_dark,
        fg = c.bg_dark,
      }
    end,
  },
  config = function(_, topts)
    local tokyonight = require('tokyonight')
    tokyonight.setup(topts)
    vim.cmd.colorscheme('tokyonight')
  end
}

package {
  'nvim-tree/nvim-tree.lua',
  dependencies = 'nvim-tree/nvim-web-devicons',
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
  keys = {
    { '<Leader>\\', cmd('NvimTreeToggle'), opts(noremap, silent), mode='n', desc='Tree' }
  },
  opts = {
    disable_netrw = false,
    hijack_cursor = true,
    hijack_netrw = true,
    view = {
      width = 35,
      hide_root_folder = true,
      signcolumn = "no",
      mappings = {
        list = {
          { key = "sh", action = "edit_vsplit" },
          { key = "sv", action = "edit_split" },
          { key = "CR", action = "edit" },
          { key = "o",  action = "o" },
          { key = "y",  action = "copy" }
        }
      },
    },
    renderer = {
      root_folder_modifier = ":t",
      indent_markers = {
        enable = false,
        inline_arrows = false,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false
        },
        glyphs = {
          folder = {
            arrow_closed = " ",
            arrow_open = " ",
          }
        }
      }
    },
    actions = {
      open_file = {
        quit_on_open = true
      }
    }
  },
  config = function(_, topts)
    local tree = require('nvim-tree')
    tree.setup(topts)

    vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg=nil })
    vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { blend=90, bg="#414868", nocombine=true })

    -- Disable cursor in tree
    vim.cmd [[
      autocmd BufWinEnter NvimTree* setlocal cursorlineopt=line guicursor+=n:Cursor
      autocmd BufEnter,FileType NvimTree* call NvimTreeHideCursor()
      autocmd BufLeave,BufWinLeave,WinClosed NvimTree* call NvimTreeShowCursor()
      function! NvimTreeHideCursor()
          highlight! Cursor blend=100
      endfunction
      function! NvimTreeShowCursor()
          highlight! Cursor blend=NONE
      endfunction
    ]]
  end
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
    "nvim-tree/nvim-web-devicons",
  },
  priority = 900,
  opts = {
    theme = 'tokyonight',
    exclude_filetypes = { "gitcommit", "toggleterm", "NvimTree" }
  }
}
