local opt = vim.opt
local cache_dir = vim.env.HOME .. '/.cache/nvim/'

opt.termguicolors = true
opt.hidden = true
opt.magic = true
opt.virtualedit = 'block'
opt.clipboard = 'unnamedplus'
opt.wildignorecase = true
opt.swapfile = false
opt.directory = cache_dir .. 'swap/'
opt.undodir = cache_dir .. 'undo/'
opt.backupdir = cache_dir .. 'backup/'
opt.viewdir = cache_dir .. 'view/'
opt.spellfile = cache_dir .. 'spell/en.uft-8.add'
opt.history = 2000
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.redrawtime = 1500
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.infercase = true
opt.autowrite = true
opt.inccommand = 'nosplit' -- preview incremental substitute

if vim.fn.executable('rg') == 1 then
  opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

opt.completeopt = 'menu,menuone,noselect'
opt.showmode = false
opt.shortmess:append({ W = true, I = true, c = true })
opt.scrolloff = 2
opt.sidescrolloff = 5
opt.ruler = false
opt.showtabline = 0
opt.winwidth = 30
opt.pumheight = 15
opt.showcmd = false

opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current

opt.cmdheight = 1
opt.laststatus = 3
opt.list = true
opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
opt.pumblend = 10
opt.winblend = 10
opt.undofile = true

opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true

-- wrap
opt.linebreak = true
opt.whichwrap = '<,>,[,],~'
opt.breakindentopt = 'shift:2,min:20'
opt.showbreak = '↳ '

opt.foldlevelstart = 99
opt.foldmethod = 'marker'

opt.number = true
opt.signcolumn = 'yes'
opt.spelloptions = 'camel'

if vim.fn.has('nvim-0.9.0') == 1 then
  opt.splitkeep = 'screen'
  opt.shortmess:append({ C = true })
end

opt.textwidth = 100
opt.colorcolumn = '100'
if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
  vim.g.python_host_prog = '/usr/bin/python'
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end

-- Autocommands
local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'checkhealth',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
