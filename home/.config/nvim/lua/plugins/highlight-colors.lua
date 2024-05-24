return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>tC",
      function()
        require("nvim-highlight-colors").toggle()
      end,
      desc = "Toggle highlight-colors",
    },
  },
  config = function()
    require("nvim-highlight-colors").setup({
      render = "background", -- background|foreground|virtual
      enable_named_colors = true,
    })
  end,
}
