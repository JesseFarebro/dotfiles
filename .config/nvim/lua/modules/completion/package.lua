local package = require('core.pack').package
local conf = require('modules.completion.config')
local keymap = require('core.keymap')
local cmd = keymap.cmd

if vim.g.vscode ~= nil then
  return
end

package({
  'neovim/nvim-lspconfig',
  -- used filetype to lazyload lsp
  -- config your language filetype in here
  ft = { 'lua', 'python', 'tex', 'bib', 'sh', 'fish' },
  dependencies = {
    'onsails/lspkind.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'SmiteshP/nvim-navic',
    'lukas-reineke/lsp-format.nvim',
    {
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local mason = require('mason-lspconfig')
    local navic = require('nvim-navic')
    local format = require('lsp-format')
    local nullls = require('null-ls')

    local function on_attach(client, buffnr)
      if client.supports_method('textDocument/documentSymbol') then
        navic.attach(client, buffnr)
      end
      format.on_attach(client, buffnr)
    end

    -- Setup LSP servers
    mason.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = on_attach,
        })
      end,
    })
    mason.setup({})

    nullls.setup({
      sources = {
        nullls.builtins.formatting.stylua,
        nullls.builtins.formatting.bibclean,
        nullls.builtins.formatting.black,
        nullls.builtins.formatting.latexindent,
        nullls.builtins.formatting.ruff,
        nullls.builtins.diagnostics.fish,
        nullls.builtins.diagnostics.ruff,
      },
      on_attach = on_attach,
    })
  end,
})

package({
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  lazy = true,
  config = true,
})

package({
  'SmiteshP/nvim-navic',
  lazy = true,
  dependencies = 'neovim/nvim-lspconfig',
})

package({
  'glepnir/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    symbol_in_winbar = {
      enable = false,
    },
    ui = {
      border = 'single',
    },
  },
  config = function(_, opts)
    local lspsaga = require('lspsaga')
    lspsaga.setup(opts)

    vim.cmd([[
      hi CursorHide gui=reverse blend=100 guifg=NONE guibg=NONE
      autocmd FileType lspsagaoutline setlocal cursorline cursorlineopt=line guicursor=n:Cursor
      autocmd FileType lspsagaoutline setlocal winhighlight=CursorLine:PmenuSel,Cursor:CursorHide
    ]])
  end,
  keys = {
    { 'gh', cmd('Lspsaga lsp_finder'), desc = 'LSP finder' },
    { '<leader>ca', cmd('Lspsaga code_action'), desc = 'Code action' },
    { 'gr', cmd('Lspsaga rename'), desc = 'Global rename' },
    { 'gp', cmd('Lspsaga peek_definition'), desc = 'Peak definition' },
    { 'gd', cmd('Lspsaga goto_definition'), desc = 'Goto definition' },
    { 'gpt', cmd('Lspsaga peek_type_definition'), desc = 'Peak type definition' },
    { 'gt', cmd('Lspsaga goto_type_definition'), desc = 'Goto type definition' },
    { '<leader>sl', cmd('Lspsaga show_line_diagnostics'), desc = 'Show line diagnostics' },
    { '[e', cmd('Lspsaga diagnostic_jump_prev'), desc = 'Previous diagnostic' },
    { ']e', cmd('Lspsaga diagnostic_jump_next'), desc = 'Next diagnostic' },
    { '<leader>o', cmd('Lspsaga outline'), desc = 'LSP outline' },
    { 'K', cmd('Lspsaga hover_doc'), desc = 'Hover doc' },
    { '<leader>ci', cmd('Lspsaga incoming_calls'), desc = 'Incoming calls' },
    { '<leader>co', cmd('Lspsaga outgoing_calls'), desc = 'Outgoing calls' },
  },
})

package({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.cmp,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'onsails/lspkind.nvim',
  },
})

package({
  'github/copilot.vim',
  event = 'InsertEnter',
})
