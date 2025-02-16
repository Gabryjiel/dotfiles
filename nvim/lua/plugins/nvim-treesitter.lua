return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			vim.defer_fn(function()
				require("nvim-treesitter.configs").setup({
					-- Add languages to be installed here that you want installed for treesitter
					ensure_installed = {
						"c",
						"css",
						"cpp",
						"go",
						"lua",
						"python",
						"rust",
						"tsx",
						"javascript",
						"typescript",
						"vimdoc",
						"vim",
						"bash",
						"toml",
						"php",
						"vue",
					},

					modules = {},
					autotag = {
						enable = true,
					},
					sync_install = false,
					ignore_install = {},

					-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
					auto_install = false,

					highlight = { enable = true },
					indent = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "<c-space>",
							node_incremental = "<c-space>",
							scope_incremental = "<c-s>",
							node_decremental = "<M-space>",
						},
					},
				})
			end, 0)
		end,
	},
}
