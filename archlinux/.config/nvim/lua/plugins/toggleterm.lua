-- terminal shell buffer
return {
	"akinsho/toggleterm.nvim",
	keys = { "<C-'>" },
	cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec", "TermSelect" },
	version = "*",
	opts = {
		open_mapping = [[<c-'>]],
		winbar = {
			enabled = true,
			name_formatter = function(term) --  term: Terminal
				return term.name
			end,
		},
	},
}
