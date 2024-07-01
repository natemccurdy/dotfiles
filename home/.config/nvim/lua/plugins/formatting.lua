return {
  "stevearc/conform.nvim",
  keys = {
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
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      json = { "jq" },
      lua = { "stylua" },
      markdown = { "injected", "prettier" },
      puppet = { "puppet-lint" },
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      ruby = { "rubocop" },
      sh = {}, -- Fall back to the bash-language-server's use of shfmt.
      terraform = { "terraform_fmt" },
      yaml = { "yamlfmt" },
      -- "_" filetypes are any without a configured formatter.
      -- ["_"] = { "trim_whitespace", "trim_newlines" }, -- Commented out because this could be dangerous.
    },
  },
}
