return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- Use a floating preview window.
      opts.window.mappings["P"] = { "toggle_preview", config = { use_float = true } }
      opts.filesystem.follow_current_file.enabled = false
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
