return {
  "allaman/kustomize.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  ft = "yaml",
  opts = {
    kinds = {
      -- setting those to false removes "clutter" but you cannot "jump" to a resource anymore
      show_filepath = true,
      show_line = true,
    },
  },
}
