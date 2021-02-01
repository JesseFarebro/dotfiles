require('utils')
local lsp = require('lspconfig')
local status = require('lsp-status')
local completion = require('completion')

fn.sign_define('LspDiagnosticsSignError', { text = '', texthl = 'LspDiagnosticsSignError' })
fn.sign_define('LspDiagnosticsSignWarning', { text = '', texthl = 'LspDiagnosticsSignWarning' })
fn.sign_define('LspDiagnosticsSignInformation', { text = '', texthl = 'LspDiagnosticsSignInformation' })
fn.sign_define('LspDiagnosticsSignHint', { text = '', texthl = 'LspDiagnosticsSignHint' })


g['completion_customize_lsp_label'] = {
    Function = '',
    Method = '',
    Reference = '',
    Enum = '',
    Field = 'ﰠ',
    Keyword = '',
    Variable = '',
    Folder = '',
    Snippet = '',
    Operator = '',
    Module = '',
    Text = 'ﮜ',
    Buffers = '',
    Class = '',
    Interface = ''
}

cmd [[inoremap <expr> <Tab> "\<C-n>" if fn.pumvisible() else "\<Tab>"]]
cmd [[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]

cmd [[set completeopt=menuone,noinsert,noselect]]
cmd [[set shortmess+=c]]

cmd [[imap <tab> <Plug>(completion_smart_tab)]]
cmd [[imap <s-tab> <Plug>(completion_smart_s_tab)]]


--map('i', '<expr> <Tab>', (fn.pumvisible() and '\\<C-n>' or '\\<Tab>'))
--map('i', '<expr> <S-Tab>', (fn.pumvisible() and '\\<C-p>' or '\\<S-Tab>'))

--opt('o', 'completeopt', 'menuone,noinsert,noselect')
--opt('o', 'shortmess', 'c')

--cmd [[ imap <tab> <Plug>(completion_smart_tab) ]]


status.config {
  kind_labels = vim.g.completion_customize_lsp_label,
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ['start'] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[1])},
        ['end'] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[2])}
      }

      return require('lsp-status/util').in_range(cursor_pos, value_range)
    end
  end,
  current_function = true,
}

status.register_progress()

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    virtual_text = {
      spacing = 2,
      prefix = "",
    },
    update_in_insert = false,
    underline = true
  }
)

local on_attach = function(client)
  status.on_attach(client)
  completion.on_attach()

  local opts = {noremap = true, silent = true}

  if client.resolved_capabilities.document_formatting then
    map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end
end

--- TeX
lsp.texlab.setup{
  settings = {
    latex = {
      build = {
          onSave = true,
          executable = "latexmk",
          args = { "-pdf", "-pvc", "-interaction=nonstopmode", "-synctex=1", "--outdir build" },
          outputDirectory = "build",
      },
      forwardSearch = {
          executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
          args = {"%l", "%p", "%f"},
          onSave = true,
      },
      lint = {
          onChange = true,
      }
    }
  },
  on_attach = on_attach,
  capabilities = status.capabilities,
}

--- Python
lsp.pyls.setup{
  on_attach = on_attach,
  capabilities = status.capabilities,
  settings = {
    python = {
      workspaceSymbols = { enabled = true },
    },
    plugins = {
      yapf = { enabled = true },
    }
  }
}
lsp.pyright.setup{
  on_attach = on_attach,
  capabilities = status.capabilities,
}

-- R
lsp.r_language_server.setup{}

-- Yaml
lsp.yamlls.setup{}

-- CMake
lsp.cmake.setup{}

-- Clang
lsp.clangd.setup{
  cmd = { "/usr/local/opt/llvm/bin/clangd", "--background-index" }
}
