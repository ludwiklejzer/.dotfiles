-- personal wiki
local function config()
	-- custom highlights
	local nvim_set_hl = vim.api.nvim_set_hl
	local nvim_create_autocmd = vim.api.nvim_create_autocmd

	nvim_create_autocmd("FileType", {
		pattern = "norg",
		callback = function()
			vim.wo.conceallevel = 2
			vim.opt_local.expandtab = true
			vim.opt_local.tabstop = 2
			vim.opt_local.shiftwidth = 2
			vim.opt_local.softtabstop = 2
		end,
	})

	nvim_set_hl(0, "@link_location", { link = "PreProc" })
	nvim_set_hl(0, "@todo_item_done", { link = "String" })
	nvim_set_hl(0, "@todo_item_cancelled", { link = "NonText" })
	nvim_set_hl(0, "@todo_item_on_hold", { link = "DiagnosticInfo" })
	nvim_set_hl(0, "@todo_item_pending", { link = "Structure" })
	nvim_set_hl(0, "@todo_item_urgent", { link = "DiagnosticError" })
	nvim_set_hl(0, "@todo_item_recurring", { link = "Keyword" })
	nvim_set_hl(0, "@todo_item_uncertain", { link = "Boolean" })
	nvim_set_hl(0, "@todo_item_undone", { link = "Delimiter" })
	nvim_set_hl(0, "@neorg.todo_items.on_hold.norg", { link = "Grey" })

	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.ui.calendar"] = {},
			["core.completion"] = { config = { engine = "nvim-cmp" } },
			["core.journal"] = {
				config = {
					strategy = "flat",
					toc_format = function(entries)
						-- Convert the entries into a certain format
						local months_text = {
							"January",
							"February",
							"March",
							"April",
							"May",
							"June",
							"July",
							"August",
							"September",
							"October",
							"November",
							"December",
						}

						local output = {}
						local current_year
						local current_month
						for _, entry in ipairs(entries) do
							-- Don't print the year if it hasn't changed
							if not current_year or current_year < entry[1] then
								current_year = entry[1]
								table.insert(output, "* " .. current_year)
							end

							-- Don't print the month if it hasn't changed
							if not current_month or current_month ~= entry[2] then
								current_month = entry[2]
								table.insert(output, "** " .. months_text[current_month])
							end

							-- Prints the file link
							table.insert(
								output,
								string.format(
									"   - %s[%d-%02d-%02d | %s]",
									entry[4],
									entry[1],
									entry[2],
									entry[3],
									entry[5]
								)
							)
						end

						return output
					end,
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
							padding = { left = 99, right = 99 },
						},
						list = {
							icons = { "∗", "٭", "•" },
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
end

return {
	"nvim-neorg/neorg",
	dependencies = { "luarocks.nvim" },
	ft = { "norg" },
	cmd = { "Neorg" },
	version = "*", -- Pin Neorg to the latest stable release
	config = config,
}
