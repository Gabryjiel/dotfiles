return {
	"mhanberg/output-panel.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("output_panel").setup({
			max_buffer_size = 5000,
		})
	end,
	cmd = { "OutputPanel" },
	keys = {
		{
			"<leader>op",
			vim.cmd.OutputPanel,
			desc = "[O]utput [P]anel",
		},
	},
}
