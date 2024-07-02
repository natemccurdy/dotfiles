return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- Use a floating preview window.
      opts.window.mappings["P"] = { "toggle_preview", config = { use_float = true } }
    end,
  },
}
