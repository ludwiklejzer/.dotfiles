-- colorscheme
local function config()
	vim.g.gruvbox_material_background = "soft"
	vim.g.gruvbox_material_transparent_background = 2
	-- vim.cmd([[colorscheme gruvbox-material]])
	vim.g.gruvbox_material_enable_italic = true

	vim.cmd([[colorscheme gruvbox-material]])

	-- set transparent hi groups
	vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
		group = nil,
		pattern = "*.norg",
		callback = function()
			vim.api.nvim_set_hl(0, "Folded", { bg = nil, fg = "#585b5c" })
		end,
	})

	local transparent_groups = {
		"StatusLine",
		"Normal",
		"NormalFloat",
		"NormalNC",
		"SignColumn",
		"Pmenu",
		"MsgSeparator",
		"LineNrAbove",
		"LineNrBelow",
		"NvimTreeNormal",
		"WinBar",
		"WinBarNC",
	}

	for _, group in ipairs(transparent_groups) do
		vim.api.nvim_set_hl(0, group, { bg = "NONE" })
	end

	-- Custom hi groups
	vim.api.nvim_set_hl(0, "@neorg.markup.verbatim", { bg = "#333333" })
	vim.api.nvim_set_hl(0, "WinSeparator", { link = "Comment" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { link = "CursorLine" })
	vim.api.nvim_set_hl(0, "CursorLineSign", { link = "CursorLine" })
end

return {
	"sainnhe/gruvbox-material",
	-- lazy = false,
	priority = 1000,
	config = config,
}
