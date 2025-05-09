---@module "lazy"
---@type LazySpec
return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    columns = {
      "size",
      "mtime",
      "icon",
    },
    view_options = {
      show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory in oil.nvim" },
    { "<leader>-", function() require("oil").open_float() end, desc = "Open floating parent directory in oil.nvim" },
  },
}
