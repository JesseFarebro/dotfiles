require('utils')

-- Auto install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

cmd [[ packadd packer.nvim ]]

return require('packer').startup(function()
  use { 
    'wbthomason/packer.nvim',
    opt = true,
    commit="043d18c3f6355e9770854d0bce13be345abfdb35"
  }

  -- Editing
  use {
    'tpope/vim-surround'
  }

  -- Tmux
  if fn.executable('tmux') then
    use {
      'roxma/nvim-yarp',
      'tmux-plugins/vim-tmux-focus-events',
      {
        'christoomey/vim-tmux-runner',
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

          g['VtrStripLeadingWhitespace'] = false
          g['VtrClearEmptyLines'] = false
          g['VtrAppendNewline'] = true
        end
      },
      'christoomey/vim-tmux-navigator'
    }
  end

  -- Git
  use {
    'mhinz/vim-signify',
    config = function()
      g['signify_sign_add'] = ''
      g['signify_sign_delete'] = ''
      g['signify_sign_delete_first_line'] = ''
      g['signify_sign_change'] = 'ﰣ'
    end
  }

  -- FZF Search
  use { 
    'nvim-lua/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    config = function()
      require('telescope').setup{
        defaults = {
          prompt_position = 'bottom',
          prompt_prefix = '   ',
          file_previewer = require'telescope.previewers'.vim_buffer_cat.new
        }
      }
      map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { silent = true })
      map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { silent = true })
      map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { silent = true })
      map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { silent = true })

      cmd [[ highlight TelescopePromptPrefix guifg=#C792EA ]]
      cmd [[ highlight TelescopeBorder guifg=#4B5263 ]]
      cmd [[ highlight TelescopePromptBorder guifg=#4B5263 ]]
      cmd [[ highlight TelescopeResultsBorder guifg=#4B5263 ]]
      cmd [[ highlight TelescopePreviewBorder guifg=#4B5263 ]]
      cmd [[ highlight TelescopeSelection guibg=#4B5263 gui=bold ]]
      cmd [[ highlight TelescopeSelectionCaret guifg=#C3E88D ]]
      cmd [[ highlight TelescopeMultiSelection guifg=#928374 ]]
      cmd [[ highlight TelescopeMatching guifg=#4FC1FF ]]
      cmd [[ highlight TelescopeNormal guibg=#3E4452 ]]
    end
  }

  -- Tab bar
  --use {
  --  'romgrk/barbar.nvim',
  --  requires = {{ 'kyazdani42/nvim-web-devicons' }}
  --}

  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {{ 'kyazdani42/nvim-web-devicons' }},
    config = function()
      g['nvim_tree_width'] = 35
      g['nvim_tree_git_hl'] = true
      g['nvim_tree_auto_close'] = true
      g['nvim_tree_quit_on_open'] = true
      g['nvim_tree_root_folder_modifier'] = ''
      g['nvim_tree_indent_markers'] = true
      g['nvim_tree_show_icons'] = {
        git = 0,
        folders = 1,
        files = 1 
      }
      g['nvim_tree_bindings'] = {
        edit_vsplit = 'sh',
        edit_split = 'sv',
        edit = { '<CR>', 'o' },
        --close_node = 'h',
        copy = 'y'
      }

      cmd [[ autocmd FileType NvimTree setlocal statusline=\  ]]
      cmd [[ autocmd FileType NvimTree setlocal scl=no ]]
      cmd [[ autocmd FileType NvimTree hi! Cursor blend=100 ]]
      cmd [[ autocmd BufEnter,FileType NvimTree set guicursor=n:Cursor/lCursor,v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 ]]
      cmd [[ autocmd BufLeave,BufWinLeave,WinClosed NvimTree set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 ]]
      cmd [[ autocmd BufLeave,BufWinLeave,WinClosed NvimTree hi! Cursor blend=NONE ]]

      map('n', '<leader>\\', ':NvimTreeToggle<CR>', { silent = true })
    end
  }

  -- Status bar
  use {
    'hoob3rt/lualine.nvim',
    config = function()
      local lualine = require'lualine'
      lualine.theme = 'onedark'
      lualine.sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location'  },
      }
      lualine.status()
    end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Start Screen
  use {
    'mhinz/vim-startify',
    config = function()
      g['startify_custom_header'] = {
        '            __',
        '    .--.--.|__|.--------.',
        '    |  |  ||  ||        |',
        '     \\___/ |__||__|__|__|',
        ''
      }
      g['startify_lists'] = {
        { type = 'dir', header = {fn.getcwd()} },
        { type = 'sessions', header = {'    Sessions'}},
        { type = 'bookmarks', header = {'    Bookmarks'}},
        { type = 'commands', header = {'    Commands'}},
      }
    end
  }

  -- TODO: Line indent... not ready yet
  -- TODO: Scrollbar... not ready yet

  -- Numbers config
  use {
    'myusuf3/numbers.vim',
    config = function()
      g['numbers_exclude'] = {'tagbar', 'startify', 'NvimTree'}
    end
  }

  -- Colors
  use {
    'Th3Whit3Wolf/one-nvim',
    config = function()
      cmd [[ syntax on ]]
      cmd [[ colorscheme one-nvim ]]
      cmd [[ hi! LineNr ctermbg=NONE guibg=NONE ]]
      cmd [[ hi! Normal ctermbg=NONE guibg=NONE ]]

      g['one_nvim_transparent_bg'] = true
    end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup()
    end
  }

  -- LSP
  use {
    {
      'neovim/nvim-lspconfig',
      config = 'require("lsp")',
    },
    'nvim-lua/completion-nvim',
    'nvim-lua/lsp-status.nvim'
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = 'require("treesitter")',
    event = 'VimEnter *'
  }
end)
