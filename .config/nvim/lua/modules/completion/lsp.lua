local key = require('core.keymap')

local nmap = key.nmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd

local lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')
local navic = require("nvim-navic")

vim.fn.sign_define('LspDiagnosticsSignError', { text = '', texthl = 'LspDiagnosticsSignError' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = '', texthl = 'LspDiagnosticsSignWarning' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = '', texthl = 'LspDiagnosticsSignInformation' })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = '', texthl = 'LspDiagnosticsSignHint' })

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

on_attach = function(client, bufnr)
  navic.attach(client, bufnr)

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

  if client.server_capabilities.document_formatting then
    nmap({'<Leader>f', cmd('vim.lsp.buf.formatting'), opts(noremap, silent)})
  end

  if client.server_capabilities.document_highlight then
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

capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  on_attach = on_attach,
  capabilities = capabilities
}
