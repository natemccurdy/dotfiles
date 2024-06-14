return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      -- https://github.com/ellisonleao/gruvbox.nvim/issues/230#issuecomment-1493883602
      overrides = {
        SignColumn = { link = "Normal" },
      },
    })
    vim.opt.background = "dark"
    vim.cmd([[colorscheme gruvbox]])
  end,
}
