-- Better status line.
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      sections = {
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = true, -- Display new file status (new file means no write after created)
            path = 1, -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory
          },
        },
      },
      inactive_sections = {
        lualine_c = {
          { "filename", path = 1 },
        },
      },
      -- change statusline appearance for a window/buffer with specified filetypes.
      extensions = {
        "lazy",
        "mason",
        "quickfix",
      },
    })
  end,
}
