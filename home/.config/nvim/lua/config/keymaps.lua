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
local copilot_on = false -- I start with Copilot OFF
vim.api.nvim_create_user_command("CopilotToggle", function()
  if copilot_on then
    vim.cmd("Copilot disable")
    print("Copilot OFF")
  else
    vim.cmd("Copilot enable")
    print("Copilot ON")
  end
  copilot_on = not copilot_on
end, { nargs = 0 })
keymap.set("", "<leader>ug", ":CopilotToggle<CR>", { noremap = true, silent = true })
