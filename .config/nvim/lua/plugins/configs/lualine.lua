local lualine = require("lualine")

lualine.setup({
	options = {
		theme = "auto",
	},
	tabline = {
		lualine_a = {},
		lualine_b = { "branch" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "tabs" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "filetype", icon_only = true }, { "filename", path = 1 } },
		lualine_c = { "diagnostics" },
		lualine_x = {
			"filesize",
			{ "encoding" },
			{ "fileformat" },
		},
		lualine_y = {},
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filetype", icon_only = true }, { "filename", path = 1 }, "diagnostics" },
		lualine_x = {
			{ "encoding" },
			{ "fileformat" },
		},
		lualine_y = {},
		lualine_z = { "location" },
	},
	extensions = { "quickfix" },
})
