return {

  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Number of lines within which surrounding is searched
      n_lines = 50,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.register({
        sa = "Add surrounding",
        sd = "Delete surrounding",
        sh = "Highlight surrounding",
        sn = "Surround update n lines",
        sr = "Replace surrounding",
        sF = "Find left surrounding",
        sf = "Find right surrounding",
        st = { "<cmd>lua require('tsht').nodes()<cr>", "TS hint textobject" },
      })
      require("mini.surround").setup(opts)
    end,
  },

  {
    "echasnovski/mini.align",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.align").setup({})
    end,
  },
}
