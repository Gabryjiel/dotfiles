return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>c", group = "Code action" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Highlight" },
      { "<leader>n", group = "Package.json" },
      { "<leader>o", group = "External panels" },
      { "<leader>r", group = "LSP actions" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Tabs" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Workspace" },
    })
  end,
}
