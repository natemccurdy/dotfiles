local utils = require("utils.functions")
-- https://neovim.io/doc/user/lua.html#vim.keymap.set()
local map = vim.keymap.set

-- Move to beginning or end of line with ^ and $.
map("n", "B", "^", { desc = "Move to begining of line" })
map("n", "E", "$", { desc = "Move to end of line" })

-- Copy and paste
map("v", "<Leader>y", '"+y', { desc = "Copy selection to clipboard" })
map("v", "<Leader>p", '"+p', { desc = "Paste from clipboard" })
map("v", "<Leader>Y", '"*y', { desc = "Copy selection to primary selection" })
map("v", "<Leader>P", '"*p', { desc = "Paste from primary selection" })
map("v", "p", '"_dp', { desc = "Paste over selection without yanking" })
map("v", "P", '"_dP', { desc = "Paste over selection without yanking" })

-- Search
map("n", "<Leader><Space>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Don't move the cursor when searching: https://vi.stackexchange.com/a/43660
map("n", "*", function()
  -- if a count was supplied, execute * normally and exit
  if vim.v.count > 0 then
    vim.cmd("normal! " .. vim.v.count .. "*<CR>")
    return
  end
  -- save current window view
  local windowView = vim.fn.winsaveview()
  -- execute * normally
  vim.cmd("silent keepjumps normal! *<CR>")
  -- restore the window view
  if windowView ~= nil then
    vim.fn.winrestview(windowView)
  end
end, { desc = "Search for word under cursor" })

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- window
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close" })
map("n", "<leader>wr", "<cmd>wincmd r<cr>", { desc = "rotate down/right" })
map("n", "<leader>wR", "<cmd>wincmd R<cr>", { desc = "rotate up/left" })
map("n", "<leader>wH", "<cmd>wincmd H<cr>", { desc = "Move left" })
map("n", "<leader>wJ", "<cmd>wincmd J<cr>", { desc = "Move down" })
map("n", "<leader>wK", "<cmd>wincmd K<cr>", { desc = "Move up" })
map("n", "<leader>wL", "<cmd>wincmd L<cr>", { desc = "Move right" })
map("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize size" })
map("n", "<leader>wk", "<cmd>resize +5<cr>", { desc = "Up" })
map("n", "<leader>wj", "<cmd>resize -5<cr>", { desc = "Down" })
map("n", "<leader>wh", "<cmd>vertical resize +3<cr>", { desc = "Left" })
map("n", "<leader>wl", "<cmd>vertical resizce -3<cr>", { desc = "Right" })

-- buffers
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })
map("n", "<leader>Bd", "<cmd>bp|bd #<cr>", { desc = "Close buffer without removing its window" })
map("n", "<leader><tab>", "<cmd>b#<cr>", { desc = "Previously openend Buffer" })

-- move over a closing element in insert mode
map("i", "<C-l>", function()
  return require("utils.functions").escapePair()
end)

-- Spelling
map("n", "<leader>zl", "<cmd>Telescope spell_suggest<cr>", { desc = "List corrections" })
map("n", "<leader>zf", "1z=", { desc = "Use first correction" })
map("n", "<leader>zj", "]s", { desc = "Next error" })
map("n", "<leader>zk", "[s", { desc = "Previous error" })
map("n", "<leader>za", "zg", { desc = "Add word" })

-- Toggles
map("n", "<leader>tn", function()
  utils.notify("Toggling relative numbers", vim.log.levels.INFO, "mappings")
  vim.o.number = vim.o.number == false and true or false
  vim.o.relativenumber = vim.o.relativenumber == false and true or false
end, { desc = "Toggle relative number" })

map("n", "<leader>th", function()
  utils.notify("Toggling hidden chars", vim.log.levels.INFO, "mappings")
  vim.o.list = vim.o.list == false and true or false
end, { desc = "Toggle hidden chars" })

map("n", "<leader>tl", function()
  utils.notify("Toggling signcolumn", vim.log.levels.INFO, "mappings")
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
end, { desc = "Toggle signcolumn" })

map("n", "<leader>tv", function()
  utils.notify("Toggling virtualedit", vim.log.levels.INFO, "mappings")
  vim.o.virtualedit = vim.o.virtualedit == "all" and "block" or "all"
end, { desc = "Toggle virtualedit" })

map("n", "<leader>ts", function()
  utils.notify("Toggling spell check", vim.log.levels.INFO, "mappings")
  vim.o.spell = vim.o.spell == false and true or false
end, { desc = "Toggle spell check" })

map("n", "<leader>tw", function()
  utils.notify("Toggling wrap", vim.log.levels.INFO, "mappings")
  vim.o.wrap = vim.o.wrap == false and true or false
end, { desc = "Toggle wrap" })

map("n", "<leader>tc", function()
  utils.notify("Toggling cursorline", vim.log.levels.INFO, "mappings")
  vim.o.cursorline = vim.o.cursorline == false and true or false
end, { desc = "Toggle cursorline" })

map("n", "<leader>tO", "<cmd>lua require('utils.functions').toggle_colorcolumn()<cr>", { desc = "Toggle colorcolumn" })
map(
  "n",
  "<leader>tt",
  "<cmd>lua require('plugins.lsp.utils').toggle_virtual_text()<cr>",
  { desc = "Toggle Virtualtext" }
)
map("n", "<leader>tS", "<cmd>windo set scb!<cr>", { desc = "Toggle Scrollbind" })
