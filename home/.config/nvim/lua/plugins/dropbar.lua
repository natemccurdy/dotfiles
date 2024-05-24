local utils = require("utils.functions")

return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  enabled = utils.isNeovimVersionsatisfied(10),
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  keys = {
    {
      "<leader>tw",
      function()
        utils.notify("Toggling winbar", vim.log.levels.INFO, "mappings")
        if vim.o.winbar == "" then
          vim.o.winbar = "%{%v:lua.dropbar.get_dropbar_str()%}"
        else
          vim.o.winbar = ""
        end
      end,
      { desc = "Toggle winbar" },
    },
    {
      "<leader>wp",
      function()
        require("dropbar.api").pick()
      end,
      desc = "Winbar pick",
    },
  },
  config = function()
    require("dropbar").setup({
      general = {
        update_interval = 100,
      },
      icons = {
        enable = true,
      },
      bar = {
        -- I don't want to see the file path in Dropbar, so return all the sources except 'sources.path'.
        sources = function()
          local sources = require("dropbar.sources")
          return { sources.treesitter, sources.markdown, sources.lsp }
        end,
      },
    })
  end,
}
