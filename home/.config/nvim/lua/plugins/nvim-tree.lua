return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "<leader>fb", "<cmd>NvimTreeToggle<cr>", desc = "File Browser (toggle on/off)" },
  },
  config = function()
    -- Disable netrw so it doesn't conflict with nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        width = {}, -- Setting width to a table makes the size dynamic. :h nvim-tree.view.width
      },
      renderer = {
        icons = {
          git_placement = "signcolumn", -- Default is 'before'
        },
      },
    })
  end,
}
