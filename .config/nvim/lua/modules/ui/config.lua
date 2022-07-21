local config = {}

function config.tokyonight()
  vim.g.tokyonight_style = 'storm'
  vim.g.tokyonight_transparent = true
  vim.g.tokyonight_hide_inactive_statusline = true
  vim.g.tokyonight_transparent_sidebar = true
  vim.g.tokyonight_lualine_bold = false
  vim.g.tokyonight_sidebars = { "packer" }
  vim.g.tokyonight_italic_functions = true
  vim.g.tokyonight_hide_inactive_statusline = true
  vim.g.tokyonight_transparent_sidebar = true
  vim.g.tokyonight_dark_float = false

  vim.cmd [[ syntax on ]]
  vim.cmd [[ colorscheme tokyonight ]]
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
  local colors = require("tokyonight.colors").setup({})

  require('bufferline').setup({
    options = {
      modified_icon = '',
      separator_style = "thick",
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
          text_align = "left"
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
