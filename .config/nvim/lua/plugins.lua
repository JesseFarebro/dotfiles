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
    -- 'beauwilliams/focus.nvim' -- Introduces bug with nvim-tree
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
    'rhysd/git-messenger.vim',
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
          prompt_position = 'bottom',
          prompt_prefix = '   ',
          file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
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

  -- Tab bar
  -- use {
  --   'romgrk/barbar.nvim',
  --   requires = {{ 'kyazdani42/nvim-web-devicons' }}
  -- }

  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {{ 'kyazdani42/nvim-web-devicons' }},
    config = function()
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback

      g.nvim_tree_width = 35
      g.nvim_tree_git_hl = true
      g.nvim_tree_auto_close = true
      g.nvim_tree_quit_on_open = true
      g.nvim_tree_root_folder_modifier = ''
      g.nvim_tree_indent_markers = true
      g.nvim_tree_show_icons = {
        git = 0,
        folders = 1,
        files = 1 
      }

      g.nvim_tree_bindings = {
        ["sh"] = tree_cb("edit_vsplit"),
        ["sv"] = tree_cb("edit_split"),
        ["CR"] = tree_cb("edit"),
        ["o"] = tree_cb("o"),
        ["y"] = tree_cb("copy")
      }

      cmd [[ autocmd BufWinEnter NvimTree setlocal scl=no ]]
      cmd [[ autocmd BufWinEnter NvimTree hi! Cursor blend=100 ]]
      cmd [[ autocmd BufWinEnter NvimTree set guicursor=n:Cursor/lCursor,v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 ]]
      cmd [[ autocmd BufLeave,BufWinLeave,WinClosed NvimTree set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 ]]
      cmd [[ autocmd BufLeave,BufWinLeave,WinClosed NvimTree hi! Cursor blend=NONE ]]

      map('n', '<leader>\\', ':NvimTreeToggle<CR>', { silent = true })
    end
  }

  use {
    "lukas-reineke/indent-blankline.nvim", branch = 'lua',
    config = function()
      g.indent_blankline_char = "│"
      g.indent_blankline_space_char = "·"
      g.indent_blankline_space_char_blankline = "·"
      g.indent_blankline_show_first_indent_level = false
      g.indent_blankline_show_trailing_blankline_indent = false
      g.indent_blankline_buftype_exclude = {"help", "terminal"}
      g.indent_blankline_filetype_exclude = {"text", "markdown", "startify", "packer", "NvimTree", "TelescopePrompt"}
      g.indent_blankline_show_current_context = true
      g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'}
      g.indent_blankline_use_treesitter = true
    end
  }

  -- Status bar
  use {
    'hoob3rt/lualine.nvim',
    config = function()
      require('lualine').setup{
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
              sources = { 'nvim_lsp' },
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
    requires = {{ 'kyazdani42/nvim-web-devicons' }}
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
    {
      'hrsh7th/nvim-compe',
      config = function()
        require'compe'.setup{
          enabled = true;
          autocomplete = true;
          debug = false;
          min_length = 1;
          preselect = 'enable';
          throttle_time = 80;
          source_timeout = 200;
          incomplete_delay = 400;
          max_abbr_width = 100;
          max_kind_width = 100;
          max_menu_width = 100;
          documentation = true;

          source = {
            path = true;
            buffer = true;
            calc = true;
            vsnip = true;
            nvim_lsp = true;
            nvim_lua = true;
            spell = true;
            tags = true;
            snippets_nvim = true;
            treesitter = true;
          };
        }

        map('i', '<C-Space>', 'compe#complete()', { expr=true, silent=true})
        map('i', '<CR>', 'compe#confirm("<CR>")', { expr=true, silent=true})
        map('i', '<C-e>', 'compe#close("<C-e>")', { expr=true, silent=true})
        map('i', '<C-f>', 'compe#scroll({ "delta: +4})', { expr=true, silent=true})
        map('i', '<C-d>', 'compe#scroll({ "delta: -4})', { expr=true, silent=true})

        local t = function(str)
          return vim.api.nvim_replace_termcodes(str, true, true, true)
        end
        local check_back_space = function()
          local col = vim.fn.col('.') - 1
          if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
              return true
          else
              return false
          end
        end
        -- Use (s-)tab to:
        --- move to prev/next item in completion menuone
        --- jump to prev/next snippet's placeholder
        _G.tab_complete = function()
          if vim.fn.pumvisible() == 1 then
            return t "<C-n>"
          elseif vim.fn.call("vsnip#available", {1}) == 1 then
            return t "<Plug>(vsnip-expand-or-jump)"
          elseif check_back_space() then
            return t "<Tab>"
          else
            return vim.fn['compe#complete']()
          end
        end
        _G.s_tab_complete = function()
          if vim.fn.pumvisible() == 1 then
            return t "<C-p>"
          elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
            return t "<Plug>(vsnip-jump-prev)"
          else
            return t "<S-Tab>"
          end
        end

        vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true, silent=true})
        vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true, silent=true})
        vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true, silent=true})
        vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true, silent=true})
      end
    },
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ'
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
end)
