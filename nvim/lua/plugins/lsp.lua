return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local bufnr = args.buf

          local nmap = function(keys, func, desc)
            if desc then desc = "LSP: " .. desc end

            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end

          nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

          nmap("gd", vim.lsp.buf.definition, "[g]o [d]efinition")
          nmap("gt", vim.lsp.buf.type_definition, "[g]o [t]ype definition")
          nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          nmap("gR", vim.lsp.buf.references, "[G]oto [R]eferences")

          nmap("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")

          -- See `:help K` for why this keymap
          nmap("K", vim.lsp.buf.hover, "Hover Documentation")
          nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
          nmap("<leader>cl", "<cmd>Format<cr>", "[F]ormat with LSP")

          -- Lesser used LSP functionality
          nmap("<leader>rs", ":LspRestart<CR>", "Restart LSP")
          nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
          nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
          nmap(
            "<leader>wl",
            function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            "[W]orkspace [L]ist Folders"
          )

          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
            vim.lsp.buf.format({ timeout_ms = 10000, async = true })
            print("Formatted")
          end, { desc = "Format current buffer with LSP" })
        end,
      })

      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      mason_lspconfig.setup({
        ensure_installed = {
          "cssls",
          "eslint",
          "html",
          "htmx",
          "jsonls",
          "gopls",
          "lua_ls",
          "cssls",
          "intelephense",
          "ts_ls",
          -- "volar",
        },
        handlers = {
          function(server) lspconfig[server].setup({ capabilities = capabilities }) end,
          intelephense = function()
            lspconfig.intelephense.setup({
              capabilities = capabilities,
              settings = {
                intelephense = {
                  files = {
                    maxSize = 9000000,
                  },
                },
              },
            })
          end,
          biome = function()
            lspconfig.biome.setup({
              capabilities = capabilities,
              root_dir = lspconfig.util.root_pattern("biome.json"),
              single_file_support = false,
            })
          end,
          eslint = function()
            lspconfig.eslint.setup({
              capabilities = capabilities,
              settings = {
                useFlatConfig = true,
              },
            })
          end,
          ["lua_ls"] = function()
            lspconfig["lua_ls"].setup({
              capabilities = capabilities,
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
            })
          end,
          ["ts_ls"] = function()
            lspconfig["ts_ls"].setup({
              capabilities = capabilities,
              init_options = {
                plugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = "/home/gabryjiel/.nvm/versions/node/v20.14.0/lib/node_modules/@vue/typescript-plugin",
                    languages = { "javascript", "typescript", "vue" },
                  },
                },
              },
              filetypes = { "javascript", "typescript", "vue", "typescriptreact", "javascriptreact" },
            })
          end,
        },
      })
    end,
  },
}
