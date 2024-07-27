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
      cue = { "cue_fmt" },
      go = { "goimports", "gofmt" },
      json = { "jq" },
      lua = { "stylua" },
      puppet = { "puppet-lint" },
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      ruby = {}, -- Use ruby-lsp's built-in Rubocop formatter, not LazyVim's extra-supplied rubocop conform formatter.
      sh = { "shellharden", lsp_format = "first" }, -- Format with the bash-language-server's shfmt first.
      terraform = { "terraform_fmt" },
      yaml = { "yamlfmt" },
      -- "_" filetypes are any without a configured formatter.
      -- ["_"] = { "trim_whitespace", "trim_newlines" }, -- Commented out because this could be dangerous.
    },
    formatters = {
      cue_fmt = {
        -- Without --files, cue throws "no language version declared in module.cue".
        args = { "fmt", "--files", "-" },
      },
    },
  },
}
