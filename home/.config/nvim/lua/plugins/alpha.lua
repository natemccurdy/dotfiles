return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "famiu/bufdelete.nvim", -- for autocmd
  },
  config = function()
    require("plugins.alpha.alpha")
  end,
}
