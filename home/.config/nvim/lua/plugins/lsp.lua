return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- Other tools and LSPs come from lazyvim.json's extras.
      vim.list_extend(opts.ensure_installed, {
        "selene", -- Lua
        "shellharden", -- Adds better variable quoting on top of bashls.
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false }, -- Hide inlay hints by default (can be toggled on with <leader>uh).
      servers = {
        -- Add servers from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        bashls = {
          filetypes = { "sh", "zsh" },
        },
        powershell_es = {},
      },
    },
  },
}
