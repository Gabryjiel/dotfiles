return {
  "vuki656/package-info.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    colors = {
      up_to_date = "237",
      outdated = "173",
    },
    style = {
      up_to_date = "| + ", -- Icon for up to date dependencies
      outdated = "| - ", -- Icon for outdated dependencies
    },
    hide_up_to_date = true,
  },
  keys = {
    { "<leader>nt", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle dependency version" },
    { "<leader>nu", "<cmd>lua require('package-info').update()<cr>", desc = "Update dependency on the line" },
    { "<leader>nd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete dependency on the line" },
    { "<leader>ni", "<cmd>lua require('package-info').install()<cr>", desc = "Install a new dependency" },
    {
      "<leader>nc",
      "<cmd>lua require('package-info').change_version()()<cr>",
      desc = "Install a different dependency version",
    },
  },
}
