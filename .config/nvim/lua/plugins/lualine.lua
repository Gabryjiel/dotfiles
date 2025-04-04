return {
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.configs.lualine")
		end,
	},
}
