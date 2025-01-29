return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "rose-pine-moon",
      -- colorscheme = "oldworld",
      -- colorscheme = "gruvbox",
      colorscheme = "gruvbox-material",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        -- theme = "rose-pine"
        -- theme = "oldworld"
        -- theme = "gruvbox",
        theme = "gruvbox-material",
      },
    },
  },

  {
    "ellisonleao/gruvbox.nvim",
  },

  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_foreground = "mix" -- material (default), mix, original
      vim.g.gruvbox_material_background = "medium" -- hard, medium (default), soft
      vim.g.gruvbox_material_enable_italic = true -- Default: false
      vim.g.gruvbox_material_enable_bold = true -- Default: false
      vim.g.gruvbox_material_transparent_background = 0 -- 0 (default), 1, 2
      vim.g.gruvbox_material_float_style = "bright" -- bright (default), dim
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored" -- grey (default), colored, highlighted
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
  },

  {
    "dgox16/oldworld.nvim",
  },
}
