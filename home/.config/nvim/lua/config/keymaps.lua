-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Copy and paste
keymap.set("v", "p", '"_dp', { desc = "Paste without yanking (after cursor)" })
keymap.set("v", "P", '"_dP', { desc = "Paste without yanking (before cursor)" })
keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Buffers
keymap.set("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })

-- Copilot
local copilot_on = true -- I start with Copilot ON
vim.api.nvim_create_user_command("CopilotToggle", function()
  if copilot_on then
    vim.cmd("Copilot disable")
    vim.api.nvim_notify("Copilot OFF", vim.log.levels.WARN, { title = "keymaps.lua" })
  else
    vim.cmd("Copilot enable")
    vim.api.nvim_notify("Copilot ON", vim.log.levels.INFO, { title = "keymaps.lua" })
  end
  copilot_on = not copilot_on
end, { nargs = 0 })
keymap.set("n", "<leader>ag", ":CopilotToggle<CR>", { desc = "Toggle Copilot" })

-- Toggle virtual_text
Snacks.toggle({
  name = "Virtual Text",
  get = function()
    return vim.diagnostic.config().virtual_text ~= false
  end,
  set = function(enabled)
    if enabled then
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many",
          spacing = 4,
        },
      })
    else
      vim.diagnostic.config({ virtual_text = false })
    end
  end,
}):map("<leader>uv")

-- Show linters for the current file type
vim.api.nvim_create_user_command("LintInfo", function()
  local filetype = vim.bo.filetype
  local linters = require("lint").linters_by_ft[filetype]

  if linters then
    print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
  else
    print("No linters configured for filetype: " .. filetype)
  end
end, {})
