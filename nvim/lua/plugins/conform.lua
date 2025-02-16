return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>cf", "<cmd>ConformFormat<cr>", desc = "Format file with Conform.nvim" },
  },
  config = function()
    local conform = require("conform")

    conform.setup({
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        php = { "prettier" },
      },
      format_after_save = {
        lsp_fallback = true,
        async = true,
        timeout_ms = 1000,
      },
    })

    vim.api.nvim_create_user_command(
      "ConformFormat",
      function()
        conform.format({
          lsp_fallback = true,
          async = true,
          timeout_ms = 1000,
        })
      end,
      {
        desc = "Format file with Conform.nvim",
      }
    )
  end,
}
