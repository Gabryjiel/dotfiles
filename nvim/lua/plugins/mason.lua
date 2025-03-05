return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  config = function()
    local mason = require("mason")
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local lspconfig = require("lspconfig")

    ---@diagnostic disable:missing-fields
    ---@type table<string, lspconfig.Config>
    local server_configs = {
      intelephense = {
        settings = {
          intelephense = {
            files = {
              maxSize = 9000000,
            },
          },
        },
      },

      biome = {
        root_dir = lspconfig.util.root_pattern("biome.json"),
        single_file_support = false,
      },

      eslint = {
        settings = {
          useFlatConfig = true,
        },
      },

      lua_ls = {
        settings = {
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },

      ["ts_ls"] = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
              languages = { "vue" },
            },
          },
        },
        filetypes = { "javascript", "typescript", "vue", "typescriptreact", "javascriptreact" },
      },
    }

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      automatic_installation = false,
      ensure_installed = {
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "gopls",
        "lua_ls",
        "cssls",
        "intelephense",
        "ts_ls",
        "volar",
      },
      handlers = {
        function(server)
          local server_config = server_configs[server] or {}
          server_config.capabilities = require("blink.cmp").get_lsp_capabilities(server_config.capabilities)
          lspconfig[server].setup(server_config)
        end,
      },
    })

    local mason_tool_installer = require("mason-tool-installer")
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint",
      },
    })
  end,
}
