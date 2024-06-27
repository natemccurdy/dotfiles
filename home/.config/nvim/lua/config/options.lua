-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = "" -- LazyVim defaults to "unnamedplus". I want more control of what goes into the clipboard.
vim.opt.conceallevel = 0 -- Don't conceal text (e.g. quotes in json, backticks in markdown).
vim.opt.cursorlineopt = "number" -- Highlight only the numer, rather than the full line, of the cursor.
vim.opt.mouse = "" -- Disable the mouse (I want tmux's mouse).
vim.opt.relativenumber = false -- I prefer to start with absolute numbers.
vim.opt.swapfile = false -- No swap files.

vim.g.trouble_lualine = false -- Don't show Trouble symbols in lualine; I use aeriel.
