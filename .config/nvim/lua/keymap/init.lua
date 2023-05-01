local keymap = require('core.keymap')
local nmap, imap, cmap, xmap, vmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.vmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '

-- better indentation
vmap({
  { '>', '>gv', opts(noremap, silent) },
  { '<', '<gv', opts(noremap, silent) },
})

-- noremal remap
nmap({
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },
})

nmap({
  { '<Leader>pu', cmd('Lazy update'), opts(noremap, silent) },
  { '<Leader>pi', cmd('Lazy install'), opts(noremap, silent) },
})
