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
  }

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

return config
