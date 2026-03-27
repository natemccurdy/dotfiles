-- https://github.com/LazyVim/LazyVim/pull/6896
vim.filetype.add({
  extension = {
    -- tofu = "opentofu",
    -- tf = "opentofu",
    tf = "terraform",
  },
})

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "hcl",
      root = ".tofu",
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "terraform", "hcl" })
      -- vim.treesitter.language.register("opentofu", "hcl")
      -- vim.treesitter.language.register("opentofu", "terraform")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tofu_ls = {
          -- Disable semantic tokens: tofu-ls sends a token per identifier across
          -- the whole file. On files with long lines (e.g. CloudWatch SEARCH
          -- expressions), neovim's UTF-16→byte conversion becomes O(lines²) and
          -- pins the CPU at 99% until the response is fully processed.
          on_attach = function(client)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        },
      },
    },
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local null_ls = require("null-ls")
  --     opts.sources = vim.list_extend(opts.sources or {}, {
  --       null_ls.builtins.formatting.opentofu_fmt,
  --       null_ls.builtins.diagnostics.opentofu_validate,
  --     })
  --   end,
  -- },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        opentofu = { "tofu" },
        terraform = { "tofu" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        opentofu = { "tofu_fmt" },
        terraform = { "tofu_fmt" },
      },
    },
  },
}
