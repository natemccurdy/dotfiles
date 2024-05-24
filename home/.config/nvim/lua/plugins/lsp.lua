-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lsp_servers = {
  "bashls", -- npm i -g bash-language-server
  "dockerls",
  "gopls",
  "helm_ls",
  "jsonls", -- npm i -g vscode-langservers-extracted
  "lua_ls", -- brew install lua-language-server
  "marksman", -- brew install marksman
  "puppet",
  "ruff", -- pip install ruff
  "terraformls",
  "tsserver",
  "typst_lsp",
  "yamlls",
}

local tools = {
  -- Formatter
  "isort",
  "prettier",
  "stylua",
  "shfmt",
  "shellharden",
  "rufo",
  -- Linter
  "hadolint",
  "shellcheck",
  "selene",
  "tflint",
  "yamllint",
  "ruff",
  -- DAP
  "debugpy",
  "delve",
  "codelldb",
  -- Go
  "gofumpt",
  "goimports",
  "gomodifytags",
  "golangci-lint",
  "gotests",
  "iferr",
  "impl",
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/lazydev.nvim" }, -- must be loaded before lsp
    },
    config = function()
      local nvim_lsp = require("lspconfig")
      local lsp_settings = require("plugins.lsp.settings")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- enable autocompletion via nvim-cmp
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      require("utils.functions").on_attach(function(client, buffer)
        require("plugins.lsp.keys").on_attach(client, buffer)

        -- workaround for gopls not supporting semanticTokensProvider
        -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        if client.name == "gopls" then
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end
        end
      end)

      for _, lsp in ipairs(lsp_servers) do
        nvim_lsp[lsp].setup({
          autostart = true,
          capabilities = capabilities,
          flags = { debounce_text_changes = 150 },
          settings = {
            json = lsp_settings.json,
            Lua = lsp_settings.lua,
            gopls = lsp_settings.gopls,
            redhat = { telemetry = { enabled = false } },
            yaml = lsp_settings.yaml,
          },
        })
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim", module = "mason" },
    },
    config = function()
      -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
      require("mason").setup({
        PATH = "append", -- Prefer system tools over Mason's versions.
      })

      -- ensure tools (except LSPs) are installed
      local mr = require("mason-registry")
      local function install_ensured()
        for _, tool in ipairs(tools) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(install_ensured)
      else
        install_ensured()
      end

      -- install LSPs
      require("mason-lspconfig").setup({ ensure_installed = lsp_servers })
    end,
  },
}
