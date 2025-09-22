return {
	"luukvbaal/statuscol.nvim",
	lazy = false,
	config = function()
		local builtin = require("statuscol.builtin")

		require("statuscol").setup({
			setopt = true,
			relculright = true,

			ft_ignore = nil,
			bt_ignore = nil,

			segments = {
				{
					text = { builtin.lnumfunc, " " },
					condition = { true, builtin.not_empty },
					click = "v:lua.ScLa",
				},
				{
					text = { "%s" },
					click = "v:lua.ScSa",
				},
			},
			clickmod = "c",

			clickhandlers = {
				Lnum = builtin.lnum_click,
				FoldClose = builtin.foldclose_click,
				FoldOpen = builtin.foldopen_click,
				FoldOther = builtin.foldother_click,
				DapBreakpointRejected = builtin.toggle_breakpoint,
				DapBreakpoint = builtin.toggle_breakpoint,
				DapBreakpointCondition = builtin.toggle_breakpoint,
				["diagnostic/signs"] = builtin.diagnostic_click,
				gitsigns = builtin.gitsigns_click,
			},
		})
	end,
}
