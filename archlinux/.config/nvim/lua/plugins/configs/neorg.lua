require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.ui.calendar"] = {},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.concealer"] = {
			config = {
				icon_preset = "diamond",
				icons = {
					heading = {
						icons = { "◈", "◇", "◆", "❖", "⟡", "⟐" },
					},
					code_block = {
						content_only = false,
					},
					todo = {
						cancelled = { icon = "" },
						done = { icon = "" },
						on_hold = { icon = "" },
						pending = { icon = "" },
						recurring = { icon = "" },
						uncertain = { icon = "" },
						undone = { icon = "" },
						urgent = { icon = "" },
					},
				},
			},
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/neorg",
				},
				default_workspace = "notes",
			},
		},
	},
})
