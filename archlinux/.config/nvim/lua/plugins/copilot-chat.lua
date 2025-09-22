return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = { "CopilotChat" },
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		opts = {
			window = {
				layout = "horizontal",
			},
		},
	},
}
