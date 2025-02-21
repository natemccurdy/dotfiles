return {
  -- https://github.com/LazyVim/LazyVim/discussions/2248
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- https://github.com/windwp/nvim-autopairs?tab=readme-ov-file#default-values
    opts = {},
  },
  -- Replace mini.pairs with nvim-autopairs
  -- https://github.com/LazyVim/LazyVim/discussions/2248
  { "echasnovski/mini.pairs", enabled = false },
}
