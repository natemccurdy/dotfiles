return {
  {
    "lewis6991/gitsigns.nvim",
    -- TODO: The gitsigns column is hidden for all but the first buffer when opening files with: 'nvim -o file1 file2 ...'
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
        },
      })

      -- Always show the sign column.
      vim.opt.signcolumn = "yes"
      -- Make the sign column transparent
      vim.cmd("highlight clear SignColumn")
    end,
  },
  -- which key integration
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      groups = {
        ["<leader>g"] = { name = "Git" },
      },
    },
  },
}
