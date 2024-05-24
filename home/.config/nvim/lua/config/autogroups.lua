local api = vim.api

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comment",
})

-- https://github.com/hashicorp/terraform-ls/blob/main/docs/USAGE.md
-- expects a terraform filetype and not a tf filetype
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf" },
  callback = function()
    vim.api.nvim_command("set filetype=terraform")
  end,
  desc = "detect terraform filetype",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "terraform-vars",
  callback = function()
    vim.api.nvim_command("set filetype=hcl")
  end,
  desc = "detect terraform vars",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "*tf", "*.hcl" },
  desc = "fix terraform and hcl comment string",
})

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "highlight on yank",
})

api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "go to last loc when opening a buffer",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "dap-float",
    "fugitive",
    "help",
    "man",
    "notify",
    "null-ls-info",
    "qf",
    "PlenaryTestPopup",
    "startuptime",
    "query",
    "spectre_panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "close certain windows with q",
})
api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
  desc = "show cursor line only in active window",
})
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex", "*.typ" },
  callback = function()
    vim.opt.spell = true
  end,
  desc = "Enable spell checking for certain file types",
})

--TODO: Add a function to toggle this because it's annoying for floating windows
--vim.api.nvim_set_hl(0, "TrailingWhitespace", { ctermbg = "White", bg = "White" })
--vim.api.nvim_set_hl(0, "LiteralTab", { ctermbg = "Yellow", bg = "Yellow" })
--local function AddLiteralTabMatch()
--  -- Don't add it on these filetypes.
--  local ft = vim.bo.filetype
--  if ft == "gitcommit" or ft == "make" or ft == "go" or ft == "cue" or ft == "lua" then
--    return
--  end
--  vim.fn.matchadd("LiteralTab", "\\t")
--end
--vim.api.nvim_create_augroup("HighlightProblems", { clear = true })
--vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
--  group = "HighlightProblems",
--  callback = function()
--    vim.fn.clearmatches()
--    vim.fn.matchadd("TrailingWhitespace", "\\s\\+$")
--    AddLiteralTabMatch()
--  end,
--  desc = "Highlight invisible characters",
--})

api.nvim_create_autocmd(
  "WinLeave",
  { pattern = "*", command = "highlight WinBar guibg=NONE", desc = "Hide DropBar's background" }
)

-- Add diagnostics to the quickfix list automatically.
-- See: https://github.com/neovim/nvim-lspconfig/issues/69#issuecomment-1877781941
vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
  group = vim.api.nvim_create_augroup("user_diagnostic_qflist", {}),
  callback = function(args)
    -- Use pcall because I was getting inconsistent errors when quitting vim.
    -- Possibly timing errors from trying to get/create diagnostics/qflists
    -- that don't exist anymore. DiagnosticChanged fires at some strange times.
    local has_diagnostics, diagnostics = pcall(vim.diagnostic.get)
    local has_qflist, qflist = pcall(vim.fn.getqflist, { title = 0, id = 0, items = 0 })
    if not has_diagnostics or not has_qflist then
      return
    end

    -- Sometimes the event fires with an empty diagnostic list in the data.
    -- This conditional prevents re-creating the qflist with the same
    -- diagnostics, which reverts selection to the first item.
    if
      #args.data.diagnostics == 0
      and #diagnostics > 0
      and qflist.title == "All Diagnostics"
      and #qflist.items == #diagnostics
    then
      return
    end

    vim.schedule(function()
      -- If the last qflist was created by this autocmd, replace it so other
      -- lists (e.g., vimgrep results) aren't buried due to diagnostic changes.
      pcall(vim.fn.setqflist, {}, qflist.title == "All Diagnostics" and "r" or " ", {
        title = "All Diagnostics",
        items = vim.diagnostic.toqflist(diagnostics),
      })

      -- Don't steal focus from other qflists. For example, when working
      -- through vimgrep results, you likely want :cnext to take you to the
      -- next match, rather than the next diagnostic. Use :cnew to switch to
      -- the diagnostic qflist when you want it.
      if qflist.id ~= 0 and qflist.title ~= "All Diagnostics" then
        pcall(vim.cmd.cold)
      end
    end)
  end,
})
