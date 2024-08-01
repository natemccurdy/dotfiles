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

  -- Vertically center the dashboard.
  -- Adapted from: https://github.com/LazyVim/LazyVim/pull/ 3780
  {
    "nvimdev/dashboard-nvim",
    config = function(_, opts)
      local header = "neovim " .. tostring(vim.version()) -- I use a simple header, no fancy ascii logo.

      local win_height = vim.api.nvim_win_get_height(0) + 2 -- plus 2 for status bar
      local _, logo_count = string.gsub(header, "\n", "") -- count newlines in logo
      local logo_height = logo_count + 3 -- logo size + newlines
      local actions_height = #opts.config.center * 2 - 1 -- minus 1 for last item
      local total_height = logo_height + actions_height + 2 -- plus for 2 for footer
      local margin = math.floor((win_height - total_height) / 2)
      local logo = string.rep("\n", margin) .. header .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      require("dashboard").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      enabled = false, -- Start disabled. Toggle with <leader>uL
    },
  },
}
