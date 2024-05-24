-- Spaces and Tabs
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Enable line numbers
vim.opt.number = true
-- Disable mouse
vim.opt.mouse = ""
-- Increase History
vim.opt.history = 100
-- Minimum number of lines above and below cursor
vim.opt.scrolloff = 14
-- Visual autocomplete for command menu
vim.opt.wildmenu = true
-- Redraw only when we need to
vim.opt.lazyredraw = true
-- highlight matching brackets
vim.opt.showmatch = true

-- Hide buffers after they are abandoned. Also allows switching buffers without
-- saving them first. This requires confirmation before closing buffers.
vim.opt.hidden = true

-- New vertical splits go to the right rather than left.
vim.opt.splitright = true
-- New horizontal splits go below the current buffer rather than above them
vim.opt.splitbelow = true

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- Highlight search results with orange.
vim.cmd([[highlight Search  ctermbg=235 ctermfg=166]])
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Allow autocompletion of words with - in them
vim.opt.iskeyword:append("-")

-- Folding
vim.opt.foldenable = true
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10

-- Movement
vim.opt.backspace = "2"

-- Backups & History
vim.opt.swapfile = false
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.undofile = true
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
vim.opt.backupdir = { prefix .. "/nvim/.backup//" }
