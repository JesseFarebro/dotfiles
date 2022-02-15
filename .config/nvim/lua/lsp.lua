require('utils')
local lsp = require('lspconfig')
local status = require('lsp-status')
local protocol = require('vim.lsp.protocol')

fn.sign_define('LspDiagnosticsSignError', { text = '', texthl = 'LspDiagnosticsSignError' })
fn.sign_define('LspDiagnosticsSignWarning', { text = '', texthl = 'LspDiagnosticsSignWarning' })
fn.sign_define('LspDiagnosticsSignInformation', { text = '', texthl = 'LspDiagnosticsSignInformation' })
fn.sign_define('LspDiagnosticsSignHint', { text = '', texthl = 'LspDiagnosticsSignHint' })

opt('o', 'completeopt', 'menu,menuone,noselect')

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

  protocol.CompletionItemKind = {
    '';   -- Text          = 1;
    '';   -- Method        = 2;
    'ƒ';   -- Function      = 3;
    '';   -- Constructor   = 4;
    'ﰠ';  -- Field         = 5;
    '';   -- Variable      = 6;
    '';   -- Class         = 7;
    '';   -- Interface     = 8;
    '';   -- Module        = 9;
    '';   -- Property      = 10;
    '';   -- Unit          = 11;
    '';   -- Value         = 12;
    '了';  -- Enum          = 13;
    '';   -- Keyword       = 14;
    '';   -- Snippet       = 15;
    '';   -- Color         = 16;
    '';   -- File          = 17;
    '';  -- Reference     = 18;
    '';   -- Folder        = 19;
    '';   -- EnumMember    = 20;
    '';   -- Constant      = 21;
    '';   -- Struct        = 22;
    '鬒';  -- Event         = 23;
    'Ψ';   -- Operator      = 24;
    '';   -- TypeParameter = 25;
  }

  local opts = {noremap = true, silent = true}

  if client.resolved_capabilities.document_formatting then
    map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      highlight LspReference guifg=NONE guibg=#665c54 guisp=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=59
      highlight! link LspReferenceText LspReference
      highlight! link LspReferenceRead LspReference
      highlight! link LspReferenceWrite LspReference

      autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
      autocmd CursorMovedI <buffer> silent! lua vim.lsp.buf.clear_references()
    ]], false)
  end
end

capabilities = vim.tbl_extend('keep', vim.lsp.protocol.make_client_capabilities(), status.capabilities)
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

-- Python
lsp.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- LanguageTool
lsp.ltex.setup{
  on_attach = on_attach,
  capabilities = capabilities
}

-- Julia
lsp.julials.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Yaml
lsp.yamlls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- CMake
lsp.cmake.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Clang
lsp.clangd.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = status.extensions.clangd.setup(),
  cmd = { "/usr/local/opt/llvm/bin/clangd", "--background-index" }
}


local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach
  }
  server:setup(opts)
end)
