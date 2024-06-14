-- Conform: Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  event = { "BufWinEnter" },
  cmd = { "ConformInfo" },
  enabled = true,
  keys = {
    { "<leader>tf", "<cmd>ToggleFormatOnSave<cr>", desc = "Toggle format on save globally" },
    { "<leader>bf", "<cmd>Format<cr>", desc = "Format current buffer" },
    {
      "_$",
      function()
        require("conform").format({ formatters = { "trim_whitespace", "trim_newlines" } }, function()
          vim.api.nvim_notify(
            "Trimmed whitespace and newlines",
            vim.log.levels.INFO,
            { title = "conform.nvim", timeout = 2000 }
          )
        end)
      end,
      desc = "Trim whitespace and newlines",
    },
  },
  opts = {
    format_on_save = function()
      -- Disable with a global variable
      if vim.g.format_on_save then
        return { timeout_ms = 500, lsp_fallback = true }
      end
    end,
    -- log_level = vim.log.levels.TRACE,
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      json = { "jq" },
      lua = { "stylua" },
      markdown = { "injected" },
      puppet = { "puppet-lint" },
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      ruby = { { "rufo", "rubocop" } },
      sh = { "shfmt", "shellharden" },
      terraform = { "terraform_fmt" },
      yaml = { "yamlfmt" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = { "trim_whitespace" },
    },
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)
    conform.formatters.shfmt = {
      prepend_args = { "-i", "2" },
    }
    conform.formatters.stylua = {
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }

    -- Default to formatting on save.
    vim.g.format_on_save = true

    -- Create a toggle for formatting on save.
    vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
      vim.g.format_on_save = not vim.g.format_on_save -- Flip the value
      vim.api.nvim_notify(
        "Format-on-save " .. (vim.g.format_on_save and "enabled" or "disabled"),
        vim.log.levels.INFO,
        { title = "conform.nvim", timeout = 2000 }
      )
    end, { desc = "Toggle format-on-save" })

    -- Create a command for formatting the current buffer.
    vim.api.nvim_create_user_command("Format", function()
      vim.api.nvim_notify("Formatting file", vim.log.levels.INFO, { title = "conform.nvim", timeout = 2000 })
      require("conform").format()
    end, { desc = "Format buffer" })
  end,
}
