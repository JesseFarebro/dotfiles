-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local key = require('core.keymap')
local nmap = key.nmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd

-- usage of plugins
nmap({
  -- packer
  { '<Leader>pu', cmd('PackerUpdate'), opts(noremap, silent) },
  { '<Leader>pi', cmd('PackerInstall'), opts(noremap, silent) },
  { '<Leader>pc', cmd('PackerCompile'), opts(noremap, silent) },
  -- dashboard
  { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
  { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
  { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
  -- nvimtree
  { '<Leader>\\', cmd('NvimTreeToggle'), opts(noremap, silent) },
  -- Telescope
  { '<Leader>b', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<Leader>fa', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  -- Tmux
  -- Move
  { '<C-h>', ':lua require"tmux".move_left()<cr>', opts(noremap, silent) },
  { '<C-j>', ':lua require"tmux".move_bottom()<cr>', opts(noremap, silent) },
  { '<C-k>', ':lua require"tmux".move_top()<cr>', opts(noremap, silent) },
  { '<C-l>', ':lua require"tmux".move_right()<cr>', opts(noremap, silent) },
  -- Resize
  { '<A-h>', ':lua require"tmux".resize_left()<cr>', opts(noremap, silent) },
  { '<A-j>', ':lua require"tmux".resize_bottom()<cr>', opts(noremap, silent) },
  { '<A-k>', ':lua require"tmux".resize_top()<cr>', opts(noremap, silent) },
  { '<A-l>', ':lua require"tmux".resize_right()<cr>', opts(noremap, silent) },
  -- Tmux Runner
  { '<Leader>sc', cmd('VtrSendCommandToRunner'), opts(noremap, silent) },
  { '<Leader>sl', cmd('VtrSendLinesToRunner'), opts(noremap, silent) },
  { '<Leader>or', cmd('VtrOpenRunner'), opts(noremap, silent) },
  { '<Leader>fr', cmd('VtrFocusRunner'), opts(noremap, silent) },
  { '<Leader>dr', cmd('VtrDetachRunner'), opts(noremap, silent) },
  { '<Leader>ar', cmd('VtrAttachToPane'), opts(noremap, silent) },
  { '<Leader>cr', cmd('VtrClearRunner'), opts(noremap, silent) },
  { '<Leader>fc', cmd('VtrFlushCommand'), opts(noremap, silent) },
  { '<Leader>scd', cmd('VtrSendCtrlD'), opts(noremap, silent) },
  { '<Leader>scc', cmd('VtrSendCtrlC'), opts(noremap, silent) },
  { '<Leader>kr', cmd('VtrKillRunner'), opts(noremap, silent) },
  -- ZenMode
  { '<Leader>z', cmd('ZenMode'), opts(noremap, silent) },
})
