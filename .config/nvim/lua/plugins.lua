require('utils')

-- Auto install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

cmd [[ packadd packer.nvim ]]

return require('packer').startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  -- Editing
  use {
    'tpope/vim-surround',
    'tpope/vim-commentary',
    'junegunn/goyo.vim',
    {
      'beauwilliams/focus.nvim',
      config = function()
        require'focus'.setup()
      end

    }
  }

  use 'ggandor/lightspeed.nvim'
  use {
    "luukvbaal/stabilize.nvim",
    config = function()
      require("stabilize").setup()
    end
  }

  use {
    "karb94/neoscroll.nvim",
    opt = false,
    config = function()
      require'neoscroll'.setup()
    end
  }

  -- Tmux
  if fn.executable('tmux') then
    use {
      'tmux-plugins/vim-tmux-focus-events',
      'christoomey/vim-tmux-runner',
      'christoomey/vim-tmux-navigator',
      config = function()
        map('n', '<leader>sc', ':<C-u>VtrSendCommandToRunner<CR>', { silent = true })
        map('n', '<leader>sl', ':<C-u>VtrSendLinesToRunner<CR>', { silent = true })
        map('n', '<leader>or', ':<C-u>VtrOpenRunner<CR>', { silent = true })
        map('n', '<leader>fr', ':<C-u>VtrFocusRunner<CR>', { silent = true })
        map('n', '<leader>dr', ':<C-u>VtrDetachRunner<CR>', { silent = true })
        map('n', '<leader>ar', ':<C-u>VtrAttachRunner<CR>', { silent = true })
        map('n', '<leader>cr', ':<C-u>VtrClearRunner<CR>', { silent = true })
        map('n', '<leader>fc', ':<C-u>VtrFlushCommand<CR>', { silent = true })
        map('n', '<leader>scd', ':<C-u>VtrSendCtrlD<CR>', { silent = true })
        map('n', '<leader>scc', ':<C-u>VtrSendCtrlC<CR>', { silent = true })

        g.VtrStripLeadingWhitespace = false
        g.VtrClearEmptyLines = false
        g.VtrAppendNewline = true
      end
    }

    -- Waiting for tmux absolute centering PR
    -- vimposter/vim-tpipeline
  end

  -- Git
  use {
    'mhinz/vim-signify',
    'tpope/vim-fugitive',
    config = function()
      g.signify_sign_add = ''
      g.signify_sign_delete = ''
      g.signify_sign_delete_first_line = ''
      g.signify_sign_change = 'ﰣ'
    end
  }

  -- FZF Search
  use { 
    'nvim-lua/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    config = function()
      local actions = require('telescope.actions')

      require('telescope').setup{
        defaults = {
          prompt_prefix = '   ',
          mappings = {
            i = {
              ["<esc>"] = actions.close
            },
          }
        }
      }
      map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { silent = true })
      map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { silent = true })
      map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { silent = true })
      map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { silent = true })
    end
  }

  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {{ 'kyazdani42/nvim-web-devicons' }},
    config = function()
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback

      g.nvim_tree_git_hl = true
      g.nvim_tree_quit_on_open = true
      g.nvim_tree_root_folder_modifier = ':t'
      g.nvim_tree_indent_markers = true
      g.nvim_tree_show_icons = {
        git = 0,
        folders = 1,
        files = 1 
      }

      require'nvim-tree'.setup{
        auto_close = true,
        view = {
          width = 35
        },
        mappings = {
          list = {
            { key = "sh", cb = tree_cb("edit_vsplit") },
            { key = "sv", cb = tree_cb("edit_split") },
            { key = "CR", cb = tree_cb("edit") },
            { key = "o",  cb = tree_cb("o") },
            { key = "y",  cb = tree_cb("copy") }
          }
        }
      }

      cmd [[ autocmd Colorscheme * highlight NvimTreeNormal guibg=NONE ctermbg=NONE ]]
      cmd [[ autocmd BufEnter,WinEnter,BufWinEnter NvimTree hi! Cursor blend=100 ]]
      cmd [[ autocmd BufEnter,WinEnter,BufWinEnter NvimTree set guicursor=n:Cursor/lCursor,v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 ]]
      cmd [[ autocmd BufLeave,BufWinLeave,WinClosed NvimTree set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 ]]
      cmd [[ autocmd BufLeave,BufWinLeave,WinClosed NvimTree hi! Cursor blend=NONE ]]

      map('n', '<leader>\\', ':NvimTreeToggle<CR>', { silent = true })
    end
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup{
        char = "│",
        space_char = "·",
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = false,
        show_current_context_start_on_current_line=false,
        show_first_indent_level=false,
        show_trailing_blankline_indent=false,
        buftype_exclude={"help", "terminal"},
        filetype_exclude={"text", "markdown", "startify", "packer", "NvimTree", "TelescopePrompt"},
        context_patterns={'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'},
        use_treesitter=true
      }
    end
  }

  -- Status bar
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      local gps = require'nvim-gps'
      gps.setup()

      require('lualine').setup{
        options = {
          theme = 'tokyonight',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff' },
          lualine_c = {
            'filename',
            { gps.get_location, condition = gps.is_available },
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
    end,
    requires = { 
      { 'kyazdani42/nvim-web-devicons', opt = true },
      'SmiteshP/nvim-gps'
    }
  }

  -- Start Screen
  use {
    'mhinz/vim-startify',
    config = function()
      g.startify_custom_header = {
        '            __',
        '    .--.--.|__|.--------.',
        '    |  |  ||  ||        |',
        '     \\___/ |__||__|__|__|',
        ''
      }
      g.startify_lists = {
        { type = 'dir', header = {fn.getcwd()} },
        { type = 'sessions', header = {'    Sessions'}},
        { type = 'bookmarks', header = {'    Bookmarks'}},
        { type = 'commands', header = {'    Commands'}},
      }
    end
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
      g.tokyonight_transparent = true
      g.tokyonight_hide_inactive_statusline = true
      g.tokyonight_transparent_sidebar = true
      g.tokyonight_lualine_bold = true
      g.tokyonight_sidebars = { "packer" }
      g.tokyonight_italic_functions = true

      cmd [[ syntax on ]]
      cmd [[ colorscheme tokyonight ]]
      cmd [[ hi! LineNr ctermbg=NONE guibg=NONE ]]
      cmd [[ hi! Normal ctermbg=NONE guibg=NONE ]]
      cmd [[ hi! CursorLineNr cterm=bold,italic gui=bold,italic ]]
    end
  }

  -- LSP
  use {
    {
      'neovim/nvim-lspconfig',
      config = 'require("lsp")',
    },
    'nvim-lua/lsp-status.nvim'
  }

  use {
    'williamboman/nvim-lsp-installer',
    requires = "neovim/nvim-lspconfig"
  }

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require'cmp'
      local lspkind = require'lspkind'

      cmp.setup{
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end
        },
        mapping = {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'buffer' },
          { name = 'calc' },
          { name = 'path' },
          { name = 'latex_symbols' },
        },
        formatting = {
          format = lspkind.cmp_format({with_text = false, maxwidth = 50})
        }
      }
    end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'kdheepak/cmp-latex-symbols',
      'onsails/lspkind-nvim'
    }
  }

  -- Syntax
  use {
    'lervag/vimtex',
    config = function()
      g.vimtex_view_method = 'skim'
    end
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true,
        }
      }
    end
  }
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = {"nvim-treesitter"},
    config = function()
      require"nvim-treesitter.configs".setup {
          textobjects = {
            select = {
              enable = true,
              disable = {},
              keymaps = {
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["aC"] = "@class.outer",
                  ["iC"] = "@class.inner",
                  ["ac"] = "@conditional.outer",
                  ["ic"] = "@conditional.inner",
                  ["ab"] = "@block.outer",
                  ["ib"] = "@block.inner",
                  ["al"] = "@loop.outer",
                  ["il"] = "@loop.inner",
                  ["is"] = "@statement.inner",
                  ["as"] = "@statement.outer",
                  ["ad"] = "@comment.outer",
                  ["am"] = "@call.outer",
                  ["im"] = "@call.inner"
              }
          },
          -- swap parameters (keymap -> textobject query)
          swap = {
              enable = true,
              swap_next = {["<leader>N"] = "@parameter.inner"},
              swap_previous = {["<leader>P"] = "@parameter.inner"}
          },
          -- set mappings to go to start/end of adjacent textobjects (keymap -> textobject query)
          move = {
              enable = true,
              goto_previous_start = {
                  ["[b"] = "@block.outer",
                  ["[m"] = "@function.outer",
                  ["[["] = "@class.outer"
              },
              goto_previous_end = {
                  ["[B"] = "@block.outer",
                  ["[M"] = "@function.outer",
                  ["[]"] = "@class.outer"
              },
              goto_next_start = {
                  ["]b"] = "@block.outer",
                  ["]m"] = "@function.outer",
                  ["]]"] = "@class.outer"
              },
              goto_next_end = {
                  ["]B"] = "@block.outer",
                  ["]M"] = "@function.outer",
                  ["]["] = "@class.outer"
              }
            }
          }
        }
    end
  }
  use {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end
  }
end)
