local config = {}

function config.tokyonight()
  require("tokyonight").setup{
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
  }

  vim.cmd [[ syntax on ]]
  vim.cmd [[ colorscheme tokyonight ]]
end

function config.telescope()
  local actions = require('telescope.actions')

  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd([[packadd plenary.nvim]])
    vim.cmd([[packadd popup.nvim]])
    vim.cmd([[packadd telescope-fzy-native.nvim]])
  end
  require('telescope').setup({
    defaults = {
      prompt_prefix = '   ',
      selection_caret = '  ',
      mappings = {
        i = {
          ["<C-j>"] = {
            actions.move_selection_next, type = "action",
            opts = { nowait = true, silent = true }
          },
          ["<C-k>"] = {
            actions.move_selection_previous, type = "action",
            opts = { nowait = true, silent = true }
          },
          ["<esc>"] = actions.close
        },
      },
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require('telescope').load_extension('fzy_native')
end

function config.indent()
  require("indent_blankline").setup{
    char = "│",
    space_char = "·",
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    show_current_context_start_on_current_line = false,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    buftype_exclude = {"help", "terminal"},
    filetype_exclude = {"text", "markdown", "packer", "NvimTree", "TelescopePrompt"},
    context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'},
    use_treesitter = true
  }
end

function config.lualine()
  local navic = require("nvim-navic")

  require('lualine').setup{
    options = {
      theme = 'tokyonight',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        'filename',
        { navic.get_location, condition = navic.is_available },
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
end

function config.bufferline()
  require('bufferline').setup({
    options = {
      modified_icon = '',
      separator_style = "thin",
      always_show_bufferline = true,
      color_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        }
      },
    },
  })
end

function config.tree()
  require('nvim-tree').setup{
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
        enable = true
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false
        }
      }
    },
    actions = {
      open_file = {
        quit_on_open = true
      }
    }
  }

  vim.cmd [[
    autocmd Colorscheme * highlight NvimTreeNormal guibg=NONE ctermbg=NONE
    autocmd Colorscheme * highlight NvimTreeCursorLine guibg=#3b4261 ctermbg=NONE
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

function config.zen()
  require("zen-mode").setup{
    window = {
      width = 0.85
    },
    on_open = function(_)
      vim.cmd 'cabbrev <buffer> q let b:quitting = 1 <bar> q'
      vim.cmd 'cabbrev <buffer> wq let b:quitting = 1 <bar> wq'
    end,
    on_close = function()
      if vim.b.quitting == 1 then
        vim.b.quitting = 0
        vim.cmd 'q'
      end
    end,
  }
end

return config
