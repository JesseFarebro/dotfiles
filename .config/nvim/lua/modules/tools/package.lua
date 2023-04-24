local package = require('core.pack').package
local keymap = require('core.keymap')

local cmd = keymap.cmd

if vim.g.vscode ~= nil then
  return
end

package({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    {
      '<Leader>b',
      cmd('Telescope buffers'),
      silent = true,
      noremap = true,
      mode = 'n',
      desc = 'Telescope Buffers',
    },
    {
      '<Leader>fa',
      cmd('Telescope live_grep'),
      silent = true,
      noremap = true,
      mode = 'n',
      desc = 'Telescope Live Grep',
    },
    { '<Leader>ff', cmd('Telescope find_files'), silent = true, noremap = true, mode = 'n', desc = 'Telescope Files' },
  },
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
  },
  opts = {
    defaults = {
      prompt_prefix = '   ',
      selection_caret = '  ',
      mappings = {
        i = {
          ['<C-j>'] = {
            function(...)
              return require('telescope.actions').move_selection_next(...)
            end,
            opts = { nowait = true, silent = true },
          },
          ['<C-k>'] = {
            function(...)
              return require('telescope.actions').move_selection_previous(...)
            end,
            opts = { nowait = true, silent = true },
          },
          ['<esc>'] = function(...)
            return require('telescope.actions').close(...)
          end,
        },
      },
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  },
  config = function(_, topts)
    local telescope = require('telescope')
    telescope.setup(topts)
    telescope.load_extension('fzy_native')
  end,
})

package({
  'beauwilliams/focus.nvim',
  opts = {
    signcolumn = false,
  },
})

package({ 'luukvbaal/stabilize.nvim', config = true })
package({ 'karb94/neoscroll.nvim', config = true })
package({ 'folke/which-key.nvim', config = true })

package({
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
  keys = {
    { '<Leader>z', cmd('ZenMode'), silent = true, noremap = true, mode = 'n', desc = 'Zen Mode' },
  },
  opts = {
    window = {
      width = 0.85,
      options = {
        signcolumn = 'no',
        number = false,
        relativenumber = false,
        cursorline = false,
        cursorcolumn = false,
        foldcolumn = '0',
        list = false,
      },
    },
    plugins = {
      gitsigns = { enabled = false },
    },
    on_open = function(_)
      vim.o.cmdheight = 1
      vim.cmd('cabbrev <buffer> q let b:quitting = 1 <bar> q')
      vim.cmd('cabbrev <buffer> wq let b:quitting = 1 <bar> wq')
    end,
    on_close = function()
      if vim.b.quitting == 1 then
        vim.b.quitting = 0
        vim.cmd('q')
      else
        vim.o.cmdheight = 0
      end
    end,
  },
})

package({ 'lervag/vimtex' })
