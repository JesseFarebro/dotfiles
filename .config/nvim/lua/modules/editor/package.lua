local package = require('core.pack').package

package({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  build = ':TSUpdate',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  opts = {
    ensure_installed = 'all',
    highlight = {
      enable = vim.g.vscode == nil,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['aC'] = '@class.outer',
          ['iC'] = '@class.inner',
          ['ac'] = '@conditional.outer',
          ['ic'] = '@conditional.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['is'] = '@statement.inner',
          ['as'] = '@statement.outer',
          ['ad'] = '@comment.outer',
          ['am'] = '@call.outer',
          ['im'] = '@call.inner',
        },
        move = {
          enable = true,
          goto_previous_start = {
            ['[b'] = '@block.outer',
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[B'] = '@block.outer',
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
          goto_next_start = {
            [']b'] = '@block.outer',
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']B'] = '@block.outer',
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
        },
      },
    },
  },
  config = function(_, topts)
    require('nvim-treesitter.configs').setup(topts)

    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  end,
})

package({
  'ggandor/lightspeed.nvim',
  keys = {
    { 's', mode = { 'n' } },
    { 'S', mode = { 'n' } },
  },
})

package({
  'echasnovski/mini.pairs',
  event = 'VeryLazy',
})

package({
  'numToStr/Comment.nvim',
  keys = {
    { 'gcc', mode = { 'n', 'v', 'x' } },
  },
  config = true,
})
