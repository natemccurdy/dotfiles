local M = {}

M._keys = {
  { "<leader>ll", vim.diagnostic.open_float, desc = "Line Diagnostics" },
  { "<leader>lR", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  { "<leader>ld", "<cmd>Trouble lsp_definitions toggle focus=false<cr>", desc = "Goto Definition", has = "definition" },
  { "<leader>lr", "<cmd>Trouble lsp_references toggle focus=false win.position=right<cr>", desc = "References" },
  { "<leader>lI", "<cmd>Trouble lsp_implementations toggle focus=false<cr>", desc = "Goto Implementation" },
  { "<leader>lt", "<cmd>Trouble lsp_type_definitions toggle focus=false<cr>", desc = "Goto Type Definition" },
  { "<leader>lk", vim.lsp.buf.hover, desc = "Hover" },
  { "<leader>lS", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
  { "<leader>ln", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { "<leader>lp", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
  { "<leader>ls", "<cmd>Trouble symbols toggle<cr>", desc = "Document Symbols" },
  { "<leader>le", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
  { "<leader>lws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
  { "<leader>lE", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
}

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}
  local wk = require("which-key")

  wk.register({
    l = {
      w = { "Workspaces" },
    },
  }, { prefix = "<leader>", mode = "n" })

  for _, value in ipairs(M._keys) do
    local keys = Keys.parse(value)
    if keys.rhs == vim.NIL or keys.rhs == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      ---@class LazyKeysBase
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
