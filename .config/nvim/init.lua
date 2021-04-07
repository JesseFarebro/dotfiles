require('utils')

----------------------------------------
-------------- Config ------------------
----------------------------------------
g['loaded_python_provider'] = false
g['python3_path'] = os.getenv('PYENV_ROOT')..'/versions/neovim3'
g['python3_host_prog'] = g['python3_path']..'/bin/python'

-- Leader
map('n', '<space>', '<Nop>')
g.mapleader = ' '

----------------------------------------
-------------- Options -----------------
----------------------------------------
local indent = 2

-- Modified buffers in background
opt('o', 'hidden', true)

-- Searching
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'hlsearch', true)

-- Undo files + backup, TODO: autoread notifications
opt('o', 'autoread', true)
opt('o', 'backup', false)
opt('o', 'swapfile', false)
opt('o', 'undodir', os.getenv('XDG_RUNTIME_DIR')..'/nvim-undodir')
opt('b', 'undofile', true)

-- Indentation
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', indent)
opt('b', 'tabstop', indent)
opt('b', 'smartindent', true)
opt('o', 'shiftround', true)
opt('w', 'wrap', true)
opt('w', 'conceallevel', 0)

-- Visuals
opt('o', 'termguicolors', true)
opt('o', 'fillchars', 'vert:┃')
opt('w', 'cursorline', true)
opt('w', 'signcolumn', 'number')
opt('o', 'updatetime', 50)
opt('o', 'fcs', 'eob: ') -- No tilde
opt('o', 'clipboard', 'unnamedplus')
opt('o', 'mouse', 'a')
opt('o', 'ruler', false)
opt('o', 'showcmd', false)

-- Splits
opt('o', 'splitbelow', true)
opt('o', 'splitright', true)

-- Numbers
opt('w', 'number', true)
opt('w', 'relativenumber', true)

----------------------------------------
-------------- Mappings ----------------
----------------------------------------
-- Arrow keys to move and delete buffers
map('n', '<Up>', '<nop>')
map('n', '<Down>', ':bd<CR>')
map('n', '<Left>', ':bp<CR>')
map('n', '<Right>', ':bn<CR>')

-- Move vertically by visual lines
map('n', 'j', 'gj', { silent = true })
map('n', 'k', 'gk', { silent = true })

-- w!! write as root
map('c', 'w!!', '!sudo tee % > /dev/null')

-- Close conforming to tmux
map('n', '<c-w>', ':<C-u>close<CR>', { silent = true })

-- CTRL-C doesn't trigger InsertLeave autocmd, map to ESC
map('i', '<c-c>', '<ESC>')

----------------------------------------
-------------- Init --------------------
----------------------------------------
require('plugins')

