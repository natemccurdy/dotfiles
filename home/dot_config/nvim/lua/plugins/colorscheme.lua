return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "gruvbox-material",
      },
    },
  },

  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_foreground = "mix" -- material (default), mix, original
      vim.g.gruvbox_material_background = "medium" -- hard, medium (default), soft
      vim.g.gruvbox_material_enable_italic = true -- Default: false
      vim.g.gruvbox_material_enable_bold = true -- Default: false
      vim.g.gruvbox_material_transparent_background = 1 -- 0 (default), 1, 2
      vim.g.gruvbox_material_float_style = "bright" -- bright (default), dim
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored" -- grey (default), colored, highlighted
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    opts = {},
  },
  {
    "ribru17/bamboo.nvim",
    opts = {},
  },
  {
    "neanias/everforest-nvim",
    version = false,
    opts = {
      background = "hard", -- soft, medium (default), hard
      transparent_background_level = 2,
    },
  },
}
