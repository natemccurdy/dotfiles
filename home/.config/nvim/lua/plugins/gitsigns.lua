-- Git diff status signs in the sign bar
-- https://github.com/lewis6991/gitsigns.nvim
return {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup({
        signs = {
          -- These symbols are easier to read than the colored bars.
          add = { text = "+" },
          change = { text = "~" },
        },
      })
    end,
  },
}
