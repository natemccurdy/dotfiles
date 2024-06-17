-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- General neovim options. Assumes defaults from NeoVim 0.10.0 and LazyVim are set.
vim.opt.clipboard = "" -- LazyVim defaults to "unnamedplus". I want more control of what goes into the clipboard.
vim.opt.conceallevel = 0 -- Don't conceal text (e.g. quotes in json, backticks in markdown).
vim.opt.cursorlineopt = "number" -- Highlight only the numer, rather than the full line, of the cursor.
vim.opt.list = false -- Start with listchars disabled (toggle with <leader>uL).
vim.opt.listchars = "tab:  ,trail:-,nbsp:+" -- Use space instead of > for tabs in listchars.
vim.opt.mouse = "" -- Disable the mouse (I want tmux's mouse).
vim.opt.relativenumber = false -- I prefer to start with absolute numbers.
vim.opt.swapfile = false -- No swap files.
vim.opt.iskeyword:append("-") -- consider string-string as whole word

-- Options specific to toggling behavior in LazyVim plugins.
vim.g.lazyvim_python_lsp = "basedpyright" -- basedpyright instead of pyright.
vim.g.lazyvim_ruby_formatter = "rubocop"
vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.trouble_lualine = false -- Don't show Trouble symbols in lualine; I use aeriel.
