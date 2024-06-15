--
-- Basic Options (assumes neovim 0.10+)
--
vim.opt.cursorline = false -- Don't show the cursor line.
vim.opt.ignorecase = true -- Ignore case while searching.
vim.opt.incsearch = true -- Search while typing the search pattern.
vim.opt.iskeyword:append("-") -- Allow autocompletion of words with - in them.
vim.opt.mouse = "" -- Disable the mouse (I want tmux's mouse).
vim.opt.number = true -- Line numbers.
vim.opt.scrolloff = 10 -- Min lines above/below cursor.
vim.opt.showmatch = true -- Highlight matching brackets.
vim.opt.signcolumn = "yes" -- Always show the signcolumn.
vim.opt.smartcase = true -- Case sensitive search only when typing an uppercase letter.
vim.opt.splitbelow = true -- New horiz splits go below.
vim.opt.splitright = true -- New vert splits go to the right.
vim.opt.swapfile = false -- No swap files.
vim.opt.undofile = true -- Create unfo files (they go in $XDG_STATE_HOME/nvim/undo/).

--
-- Mappings
--
local map = vim.keymap.set

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

-- Windows
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

-- Buffers
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })
map("n", "<leader>Bd", "<cmd>bp|bd #<cr>", { desc = "Close buffer without removing its window" })
map("n", "<leader><tab>", "<cmd>b#<cr>", { desc = "Previously openend Buffer" })
vim.api.nvim_create_user_command("Bd", "bp | bd #", { nargs = 0, desc = "Close buffer without removing its window" })

-- Spelling
map("n", "<leader>zl", "<cmd>Telescope spell_suggest<cr>", { desc = "List corrections" })
map("n", "<leader>zf", "1z=", { desc = "Use first correction" })
map("n", "<leader>zj", "]s", { desc = "Next error" })
map("n", "<leader>zk", "[s", { desc = "Previous error" })
map("n", "<leader>za", "zg", { desc = "Add word" })

--
-- Toggles
--
map("n", "<leader>tr", function()
  vim.api.nvim_notify("Toggling relative numbers", vim.log.levels.INFO, { title = "toggles", timeout = 2000 })
  vim.o.relativenumber = vim.o.relativenumber == false and true or false
end, { desc = "Toggle relative number" })

map("n", "<leader>th", function()
  vim.api.nvim_notify("Toggling hidden characters", vim.log.levels.INFO, { title = "toggles", timeout = 2000 })
  vim.o.list = vim.o.list == false and true or false
end, { desc = "Toggle hidden characters" })

map("n", "<leader>tl", function()
  vim.api.nvim_notify("Toggling signcolumn", vim.log.levels.INFO, { title = "toggles", timeout = 2000 })
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
end, { desc = "Toggle signcolumn" })

map("n", "<leader>ts", function()
  vim.api.nvim_notify("Toggling spellcheck", vim.log.levels.INFO, { title = "toggles", timeout = 2000 })
  vim.o.spell = vim.o.spell == false and true or false
end, { desc = "Toggle spell check" })

map("n", "<leader>tw", function()
  vim.api.nvim_notify("Toggling wrap", vim.log.levels.INFO, { title = "toggles", timeout = 2000 })
  vim.o.wrap = vim.o.wrap == false and true or false
end, { desc = "Toggle wrap" })

map("n", "<leader>tc", function()
  vim.api.nvim_notify("Toggling cursorline", vim.log.levels.INFO, { title = "toggles", timeout = 2000 })
  vim.o.cursorline = vim.o.cursorline == false and true or false
end, { desc = "Toggle cursorline" })

-- TODO: Consider using:
--   vim.diagnostic.config({
--     virtual_text = false,
--   })
--   OR https://github.com/neovim/neovim/issues/14825
--
-- map(
--   "n",
--   "<leader>tt",
--   "<cmd>lua require('plugins.lsp.utils').toggle_virtual_text()<cr>",
--   { desc = "Toggle Virtualtext" }
-- )

--
-- Setup lazy.nvim (plugin manager)
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins. Automatically loads files from ~/.config/nvim/lua/plugins/.
require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    notify = false, -- Hide the "plugin change detected" prompt.
  },
})

--
-- LSP
--

-- Set up Mason and install language servers
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
    })
  end,
})

-- Global LSP mappings
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostics window (float)" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto prev diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics in location list" })

-- More LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>.", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
})

-- Set up nvim-cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp", max_item_count = 5 },
    { name = "buffer", max_item_count = 5 },
    { name = "path", max_item_count = 3 },
    { name = "luasnip", max_item_count = 3 },
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
      return vim_item
    end,
  },
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
