return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
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

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
  },
}
