local package = require('core.pack').package

package {
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
        },
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
      },
    },
  },
  config = function(_, topts)
    require('nvim-treesitter.configs').setup(topts)

    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  end
}

package {
  'ggandor/lightspeed.nvim',
  keys = {
    { "s", mode = { "n" } },
    { "S", mode = { "n" } },
  }
}

package { 'kylechui/nvim-surround' }

package {
  'numToStr/Comment.nvim',
  keys = {
    { "gc", mode = { "n", "v", "x" } },
    { "gcc", mode = { "n", "v", "x" } },
    { "gb", mode = { "n", "v", "x" } },
    {
        "<Leader>/",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = "n",
        desc = "Comment",
    },
    {
        "<Leader>/",
        function()
          local esc = vim.api.nvim_replace_termcodes(
            '<ESC>', true, false, true
          )
          vim.api.nvim_feedkeys(esc, 'nx', false)
          require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end,
        mode = "v",
        desc = "Comment",
    }
  },
  config = true,
}
