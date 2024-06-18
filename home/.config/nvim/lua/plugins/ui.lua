local logo = [[
██╗  ██╗██╗    ███╗   ██╗ █████╗ ████████╗███████╗
██║  ██║██║    ████╗  ██║██╔══██╗╚══██╔══╝██╔════╝
███████║██║    ██╔██╗ ██║███████║   ██║   █████╗  
██╔══██║██║    ██║╚██╗██║██╔══██║   ██║   ██╔══╝  
██║  ██║██║    ██║ ╚████║██║  ██║   ██║   ███████╗
╚═╝  ╚═╝╚═╝    ╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
]]
logo = string.rep("\n", 8) .. logo .. "\n\n"

return {

  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Match my theme.
      opts.options.theme = "gruvbox-material"

      -- Show file type name and icon in lualine_c.
      -- https://github.com/LazyVim/LazyVim/discussions/3709
      for _, component in ipairs(opts.sections.lualine_c) do
        if component[1] == "filetype" then
          component.icon_only = false
        end
      end

      -- Show LSPs and  formatters in lualine_z instead of the date/time.
      opts.sections.lualine_z = {
        {
          function()
            local lsps = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
            if lsps and #lsps > 0 then
              local names = {}
              for _, lsp in ipairs(lsps) do
                table.insert(names, lsp.name)
              end
              return string.format("%s", table.concat(names, ", "))
            else
              return ""
            end
          end,
        },
        {
          function()
            -- Check if 'conform' is available
            local status, conform = pcall(require, "conform")
            if not status then
              return "Conform not installed"
            end

            local lsp_format = require("conform.lsp_format")

            -- Get formatters for the current buffer
            local formatters = conform.list_formatters_for_buffer()
            if formatters and #formatters > 0 then
              local formatterNames = {}

              for _, formatter in ipairs(formatters) do
                table.insert(formatterNames, formatter)
              end

              return "󰷈 " .. table.concat(formatterNames, " ")
            end

            -- Check if there's an LSP formatter
            local bufnr = vim.api.nvim_get_current_buf()
            local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

            if not vim.tbl_isempty(lsp_clients) then
              return "󰷈 LSP Formatter"
            end

            return ""
          end,
        },
      }
    end,
  },

  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        header = vim.split(logo, "\n"),
      },
    },
  },
}
