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

      -- Overrides for lualine_c. I'm just copying the default and modifying
      -- the entire table because modifying sub-tables reliably is beyond me.
      -- Default: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua
      local icons = LazyVim.config.icons
      opts.sections.lualine_c = {
        LazyVim.lualine.root_dir(),
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        -- Show file type's text and icon.
        { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
        -- Don't truncate file paths.
        { LazyVim.lualine.pretty_path({ length = 0 }) },
      }
      -- do not add trouble symbols if aerial is enabled
      if vim.g.trouble_lualine then
        local trouble = require("trouble")
        local symbols = trouble.statusline
          and trouble.statusline({
            mode = "symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            hl_group = "lualine_c_normal",
          })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = symbols and symbols.has,
        })
      end

      -- Add aerial symbols to lualine.
      if not vim.g.trouble_lualine then
        table.insert(opts.sections.lualine_c, {
          "aerial",
          sep = " ", -- separator between symbols
          sep_icon = "", -- separator between icon and symbol

          -- The number of symbols to render top-down. In order to render only 'N' last
          -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
          -- be used in order to render only current symbol.
          depth = 5,

          -- When 'dense' mode is on, icons are not rendered near their symbols. Only
          -- a single icon that represents the kind of current symbol is rendered at
          -- the beginning of status line.
          dense = false,

          -- The separator to be used to separate symbols in dense mode.
          dense_sep = ".",

          -- Color the symbol icons.
          colored = true,
        })
      end

      -- Show LSPs, linters, and formatters in lualine_z instead of the date/time.
      opts.sections.lualine_z = {

        -- Show running LSPs.
        {
          function()
            local lsps = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
            if lsps and #lsps > 0 then
              local names = {}
              for _, lsp in ipairs(lsps) do
                table.insert(names, lsp.name)
              end
              return " " .. table.concat(names, " ")
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
              local names = {}
              for _, linter in ipairs(linters) do
                table.insert(names, linter)
              end
              return "󱪙 " .. table.concat(names, " ")
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

            -- Get formatters for the current buffer
            local formatters = conform.list_formatters_for_buffer()
            if formatters and #formatters > 0 then
              local names = {}
              for _, formatter in ipairs(formatters) do
                table.insert(names, formatter)
              end
              return "󰷈 " .. table.concat(names, " ")
            end

            -- Check if there's an LSP formatter
            local bufnr = vim.api.nvim_get_current_buf()
            local lsp_clients = require("conform.lsp_format").get_format_clients({ bufnr = bufnr })
            if not vim.tbl_isempty(lsp_clients) then
              return "󰷈 LSP"
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
        -- The Doom theme that LazyVim uses doesn't automatically vertically
        -- center itself, so add some newlines for vertical padding. See
        -- https://github.com/nvimdev/dashboard-nvim/issues/354
        header = vim.split("\n\n\nneovim " .. tostring(vim.version()) .. "\n\n", "\n"),
      },
    },
  },
}
