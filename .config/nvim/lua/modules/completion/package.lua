local package = require('core.pack').package
local conf = require('modules.completion.config')

if vim.g.vscode ~= nil then
  return
end

package {
  'neovim/nvim-lspconfig',
  -- used filetype to lazyload lsp
  -- config your language filetype in here
  ft = { 'lua', 'python', 'tex' },
  dependencies = {
    'onsails/lspkind.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'SmiteshP/nvim-navic',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local mason = require('mason-lspconfig')
    local navic = require('nvim-navic')

    -- Setup LSP servers
    mason.setup_handlers {
      function(server_name)
        lspconfig[server_name].setup{
          on_attach = function(client, bufnr)
            navic.attach(client, bufnr)
          end
        }
      end
    }
    mason.setup{}
  end,
}

package {
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  lazy = true,
  config = true,
}

package {
  "SmiteshP/nvim-navic",
  lazy = true,
  dependencies = "neovim/nvim-lspconfig",
}

package {
  'glepnir/lspsaga.nvim',
  event = 'BufRead',
}

package {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.cmp,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'onsails/lspkind.nvim',
  },
}

package {
  'github/copilot.vim',
  event = 'InsertEnter',
}
