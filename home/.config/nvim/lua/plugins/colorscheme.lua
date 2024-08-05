return {
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   version = false,
  --   config = function()
  --     require("gruvbox").setup({
  --       -- https://github.com/ellisonleao/gruvbox.nvim/issues/230
  --       --
  --       -- Also see this issue with more specific highlight overrides that
  --       -- might be useful:
  --       -- https://github.com/ellisonleao/gruvbox.nvim/issues/305#issuecomment-1853057993
  --       overrides = {
  --         CursorLineNr = { bg = "" }, -- https://github.com/ellisonleao/gruvbox.nvim/discussions/344
  --         GruvboxAquaSign = { bg = "" },
  --         GruvboxBlueSign = { bg = "" },
  --         GruvboxGreenSign = { bg = "" },
  --         GruvboxOrangeSign = { bg = "" },
  --         GruvboxPurpleSign = { bg = "" },
  --         GruvboxRedSign = { bg = "" },
  --         GruvboxYellowSign = { bg = "" },
  --         SignColumn = { link = "LineNr" }, -- https://github.com/ellisonleao/gruvbox.nvim/issues/304#issuecomment-1915875057
  --       },
  --     })
  --   end,
  -- },
  {
    "sainnhe/gruvbox-material",
    version = false,
    config = function()
      vim.g.gruvbox_material_foreground = "mix" -- material (default), mix, original
      vim.g.gruvbox_material_background = "medium" -- hard, medium (default), soft
      vim.g.gruvbox_material_enable_italic = true -- Default: false
      vim.g.gruvbox_material_enable_bold = true -- Default: false
      vim.g.gruvbox_material_transparent_background = 0 -- 0 (default), 1, 2
      vim.g.gruvbox_material_float_style = "dim" -- bright (default), dim
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored" -- grey (default), colored, highlighted
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "gruvbox-material"
    end,
  },
}
