return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-endwise",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Automatically install missing parsers when entering buffer.
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,
      ensure_installed = {
        "bash",
        "cue",
        "diff",
        "dockerfile",
        "go",
        "hcl",
        "html",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "puppet",
        "python",
        "query",
        "regex",
        "terraform",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
      -- Use treesitter highlighting.
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          scope_incremental = "<CR>",
          node_incremental = "<TAB>",
          node_decremental = "<S-TAB>",
        },
      },
      endwise = {
        enable = true,
      },
      indent = { enable = true },
      autopairs = { enable = true },
    })
  end,
}
