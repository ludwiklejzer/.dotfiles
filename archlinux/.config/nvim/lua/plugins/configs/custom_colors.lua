local wally_colors = require("wally.colors")
local wally_config = require("wally.config")
local hl = vim.api.nvim_set_hl

local colors = wally_colors.setup(wally_config)
local transparent_groups = {
	"Normal",
	"NormalFloat",
	"NormalNC",
	"LineNr",
	"SignColumn",
	"Pmenu",
}

for _, group in ipairs(transparent_groups) do
	hl(0, group, { bg = "NONE" })
end

hl(0, "CursorLine", { bg = colors.dark3, fg = "NONE" })
hl(0, "VertSplit", { bg = "NONE", fg = colors.bg_highlight })
hl(0, "FloatBorder", { bg = "NONE", fg = colors.bg_highlight })
hl(0, "StatusLine", { bg = "NONE" })
hl(0, "Folded", { bg = "NONE", fg = colors.bg_highlight })
hl(0, "IlluminatedWordWrite", { bg = colors.bg_highlight })
hl(0, "IlluminatedWordText", { bg = colors.bg_highlight })
hl(0, "IlluminatedWordRead", { bg = colors.bg_highlight })
hl(0, "NvimTreeNormal", { bg = "NONE" })
