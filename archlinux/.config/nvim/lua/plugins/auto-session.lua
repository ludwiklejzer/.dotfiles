return {
	"rmagatti/auto-session",
	-- lazy = false,
	enabled = false,
	opts = {
		allowed_dirs = { "~/Workbench/*" },
		session_lens = {
			theme_conf = {
				layout_config = {
					height = 13,
					width = function()
						local win_width = vim.api.nvim_win_get_width(0)
						if win_width > 70 then
							return 60
						else
							return win_width - 2
						end
					end,
					preview_cutoff = 130,
					prompt_position = "top",
				},
			},
			previewer = true,
		},
	},
}
