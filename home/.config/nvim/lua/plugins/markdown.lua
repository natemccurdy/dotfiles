return {
  url = "https://github.com/MeanderingProgrammer/markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "<leader>tm", "<cmd>RenderMarkdownToggle<cr>", desc = "Toggle markdown rendering", ft = "markdown" },
  },
  config = function()
    require("render-markdown").setup({
      start_enabled = false,
    })
  end,
}
