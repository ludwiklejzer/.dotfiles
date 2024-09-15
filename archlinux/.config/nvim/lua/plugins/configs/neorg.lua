-- custom highlights
local nvim_set_hl = vim.api.nvim_set_hl
-- local nvim_get_hl = function(name)
-- 	return vim.api.nvim_get_hl(0, { name = name })
-- end

nvim_set_hl(0, "@link_location", { link = "PreProc" })
nvim_set_hl(0, "@todo_item_done", { link = "String" })
nvim_set_hl(0, "@todo_item_cancelled", { link = "NonText" })
nvim_set_hl(0, "@todo_item_on_hold", { link = "DiagnosticInfo" })
nvim_set_hl(0, "@todo_item_pending", { link = "Structure" })
nvim_set_hl(0, "@todo_item_urgent", { link = "DiagnosticError" })
nvim_set_hl(0, "@todo_item_recurring", { link = "Keyword" })
nvim_set_hl(0, "@todo_item_uncertain", { link = "Boolean" })
nvim_set_hl(0, "@todo_item_undone", { link = "Delimiter" })

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
				folds = true,
				icon_preset = "diamond",
				icons = {
					heading = {
						icons = { "◈", "◇", "◆", "❖", "⟡", "⟐" },
					},
					code_block = {
						conceal = false,
						content_only = false,
						-- width = "content",
						padding = { left = 2, right = 2 },
					},
					list = {
						icons = { "•", "∗", "٭" },
					},
					todo = {
						cancelled = { icon = "x" },
						done = { icon = "" },
						on_hold = { icon = "" },
						pending = { icon = "󰚭" },
						recurring = { icon = "+" },
						uncertain = { icon = "?" },
						undone = { icon = " " },
						urgent = { icon = "!" },
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
