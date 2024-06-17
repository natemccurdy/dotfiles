return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- Use a floating preview window.
      opts.window.mappings["P"] = { "toggle_preview", config = { use_float = true } }
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern", -- classic (default), modern, helix
      delay = 1500, -- Default is 200ms
    },
  },
}
