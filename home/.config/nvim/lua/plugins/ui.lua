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
        indicator = { style = "none" },
        separator_style = "thin", -- :h bufferline-styling
        show_buffer_close_icons = false,
        show_close_icon = false,
        style_preset = "minimal", -- :h bufferline-style-presets
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Override LazyVim's default of no options being passed to pretty_path().
      --   * Don't truncate paths
      -- NOTE: This assumes pretty_path() is the 4th item in the lualine_c table.
      -- opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({ length = 0 }) }
      opts.sections.lualine_c[4] = { "filename", path = 3 }

      -- Show LSPs, linters, and formatters in lualine_z instead of the date/time.
      opts.sections.lualine_z = {

        -- Show running LSPs.
        {
          function()
            local lsps = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
            if lsps and #lsps > 0 then
              -- local names = {}
              -- for _, lsp in ipairs(lsps) do
              --   table.insert(names, lsp.name)
              -- end
              -- return " " .. table.concat(names, " ")
              return " " .. tostring(#lsps)
            else
              return ""
            end
          end,
        },

        -- Show nvim-lint linters
        {
          function()
            local status, nvim_lint = pcall(require, "lint")
            if not status then
              return ""
            end
            -- Get linters for the current buffer.
            local linters = nvim_lint.linters_by_ft[vim.bo.filetype] or {}
            if linters and #linters > 0 then
              -- local names = {}
              -- for _, linter in ipairs(linters) do
              --   table.insert(names, linter)
              -- end
              -- return "󱪙 " .. table.concat(names, " ")
              return "󱪙 " .. tostring(#linters)
            end

            return ""
          end,
        },

        -- Show nvim-conform formatters.
        {
          function()
            -- Check if 'conform' is available
            local status, conform = pcall(require, "conform")
            if not status then
              return ""
            end

            local names = {}

            -- Get formatters for the current buffer
            local formatters = conform.list_formatters_for_buffer()
            if formatters and #formatters > 0 then
              for _, formatter in ipairs(formatters) do
                table.insert(names, formatter)
              end
            end

            -- Check if there's an LSP formatter
            local bufnr = vim.api.nvim_get_current_buf()
            local lsp_clients = require("conform.lsp_format").get_format_clients({ bufnr = bufnr })

            if not vim.tbl_isempty(lsp_clients) then
              local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
              if conform.formatters_by_ft[ft]["lsp_format"] == "first" then
                table.insert(names, 1, "LSP")
              else
                table.insert(names, "LSP")
              end
            end

            if #names > 0 then
              -- return "󰷈 " .. table.concat(names, " ")
              return "󰷈 " .. tostring(#names)
            else
              return ""
            end
          end,
        },
      }
    end,
  },

  -- https://www.lazyvim.org/plugins/ui#snacksnvim
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = false }, -- Disable indent guide lines. Toggle with <leader>ug
    },
  },
}
