-- colorscheme
local function config()
	vim.g.everforest_transparent_background = 2
	vim.g.everforest_enable_italic = true
	vim.g.everforest_current_word = "underline"
	vim.g.everforest_background = "dark"
	vim.g.everforest_float_style = "dim"

	vim.cmd([[colorscheme everforest]])

	-- set transparent hi groups
	vim.api.nvim_create_autocmd({ "WinEnter" }, {
		once = true,
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
		-- "LineNrAbove",
		-- "LineNrBelow",
		"NvimTreeNormal",
		"WinBar",
		"WinBarNC",
	}

	for _, group in ipairs(transparent_groups) do
		vim.api.nvim_set_hl(0, group, { bg = "NONE" })
	end

	-- Custom hi groups
	vim.api.nvim_set_hl(0, "@neorg.tags.ranged_verbatim.code_block", { bg = "#333333" })
	vim.api.nvim_set_hl(0, "@neorg.markup.verbatim", { bg = "#333333" })
	vim.api.nvim_set_hl(0, "WinSeparator", { link = "Comment" })
	vim.api.nvim_set_hl(0, "@neorg.links.location.timestamp.norg", { link = "Comment" })
	-- vim.api.nvim_set_hl(0, "LineNrAbove", { link = "Folded" })
	-- vim.api.nvim_set_hl(0, "LineNrBelow", { link = "Folded" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3a3e3e" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { link = "CursorLine" })
	vim.api.nvim_set_hl(0, "CursorLineSign", { link = "CursorLine" })
	vim.api.nvim_set_hl(0, "CursorLineFold", { link = "CursorLine" })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#3a3e3e" })
	vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeBorder" })
end

return {
	"sainnhe/everforest",
	lazy = false,
	priority = 1000,
	config = config,
}
