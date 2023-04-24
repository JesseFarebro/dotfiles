require('core')

if vim.g.vscode ~= nil then
  vim.cmd([[ syntax off ]])
  -- https://github.com/vscode-neovim/vscode-neovim/issues/846
  vim.cmd([[ autocmd BufEnter *.ipynb#* if mode() == 'n' | call feedkeys('a\<C-c>') ]])
end
