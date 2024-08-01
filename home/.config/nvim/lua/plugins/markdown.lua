return {
  {
    -- Temp fix for markdown-preview error at install.
    -- https://github.com/LazyVim/LazyVim/pull/4196
    "iamcco/markdown-preview.nvim",
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "MeanderingProgrammer/markdown.nvim",
    opts = {
      code = { position = "right" },
    },
  },
}
