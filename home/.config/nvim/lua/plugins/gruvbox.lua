return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    -- https://github.com/ibhagwan/fzf-lua/blob/main/README.md#default-options
    require("gruvbox").setup({
      overrides = {
        -- https://github.com/Bekaboo/dropbar.nvim/issues/118
        WinBarNC = { bg = "NONE" },
        SignColumn = { bg = "NONE" },
      },
    })
    vim.opt.background = "dark"
    vim.cmd("colorscheme gruvbox")
  end,
}
