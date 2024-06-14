-- Linting files with https://github.com/mfussenegger/nvim-lint
return {
  "mfussenegger/nvim-lint",
  lazy = false,
  keys = {
    { "<leader>tL", "<cmd>ToggleLinting<cr>", desc = "Toggle Linting" },
  },
  opts = {
    linters_by_ft = {
      cue = { "cue" },
      dockerfile = { "hadolint" },
      go = { "golangcilint" },
      lua = { "selene" },
      puppet = { "puppet-lint" },
      python = { "ruff" }, -- TODO: Consider a custom ruff linter to catch more things by default -- https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/ruff.lua
      yaml = { "yamllint" },
      -- sh = { "shellcheck" } -- Disabled because bashls handles it.
    },
  },
  config = function(_, opts)
    -- Default to linting automatically
    vim.g.lint_enabled = true

    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({ "BufModifiedSet", "BufWinEnter", "BufWritePost", "BufWritePre", "InsertLeave" }, {
      callback = function()
        if vim.g.lint_enabled then
          lint.try_lint()
        end
      end,
    })

    vim.api.nvim_create_user_command("ToggleLinting", function()
      vim.g.lint_enabled = not vim.g.lint_enabled -- Flip the value
      local status = vim.g.lint_enabled and "enabled" or "disabled"
      vim.api.nvim_notify("Linting " .. status, vim.log.levels.INFO, { title = "nvim-lint", timeout = 2000 })
      if not vim.g.lint_enabled then
        vim.diagnostic.hide()
      end
    end, { desc = "Toggle Linting" })
  end,
}
