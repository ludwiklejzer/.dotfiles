local wally_colors = require("wally.colors")
local wally_config = require("wally.config")
local colors = wally_colors.setup(wally_config)

local wally = {
	normal = {
		a = { bg = colors.blue, fg = colors.bg },
		b = { bg = "NONE", fg = colors.blue },
		c = { bg = "NONE", fg = colors.blue7 },
		x = { bg = "NONE", fg = colors.blue7 },
		y = { bg = "NONE", fg = colors.blue },
		z = { bg = colors.blue, fg = colors.bg },
	},
	insert = {
		a = { bg = colors.red, fg = colors.bg },
		b = { bg = "NONE", fg = colors.red },
		c = { bg = "NONE", fg = colors.red1 },
		x = { bg = "NONE", fg = colors.red1 },
		y = { bg = "NONE", fg = colors.red },
		z = { bg = colors.red, fg = colors.bg },
	},
	visual = {
		a = { bg = colors.green, fg = colors.bg },
		b = { bg = "NONE", fg = colors.green },
		c = { bg = "NONE", fg = colors.green2 },
		x = { bg = "NONE", fg = colors.green2 },
		y = { bg = "NONE", fg = colors.green },
		z = { bg = colors.green, fg = colors.bg },
	},
	replace = {
		a = { bg = colors.magenta, fg = colors.bg },
		b = { bg = "NONE", fg = colors.magenta },
		c = { bg = "NONE", fg = colors.purple },
		x = { bg = "NONE", fg = colors.purple },
		y = { bg = "NONE", fg = colors.magenta },
		z = { bg = colors.magenta, fg = colors.bg },
	},
	command = {
		a = { bg = colors.cyan, fg = colors.bg },
		b = { bg = "NONE", fg = colors.cyan },
		c = { bg = "NONE", fg = colors.blue1 },
		x = { bg = "NONE", fg = colors.blue1 },
		y = { bg = "NONE", fg = colors.cyan },
		z = { bg = colors.cyan, fg = colors.bg },
	},
	inactive = {
		a = { bg = colors.blue, fg = colors.bg },
		b = { bg = "NONE", fg = colors.blue },
		c = { bg = "NONE", fg = colors.blue7 },
		x = { bg = "NONE", fg = colors.blue7 },
		y = { bg = "NONE", fg = colors.blue },
		z = { bg = colors.blue, fg = colors.bg },
	},
}
local function lsp_clients()
	local active_clients = vim.lsp.get_active_clients()
	if not active_clients or #active_clients == 0 then
		return "No Servers"
	end
	local names = {}
	for _, client in ipairs(active_clients) do
		table.insert(names, client.name)
	end

	local str = table.concat(names, " / ")
	return str
end

local mode = {
	"mode",
	separator = { left = "", right = "" },
	fmt = function(str)
		if str == "NORMAL" then
			return " " .. str
		elseif str == "INSERT" then
			return " " .. str
		elseif str == "VISUAL" then
			return "󰕢 " .. str
		elseif str == "V-LINE" then
			return "󰒉 " .. str
		elseif str == "V-BLOCK" then
			return "󰩭 " .. str
		elseif str == "REPLACE" then
			return "󰛔 " .. str
		elseif str == "COMMAND" then
			return " " .. str
		end
	end,
}

local branch = {
	"branch",
	fmt = function(str)
		return str
	end,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " },
}

local diagnostics = {
	"diagnostics",
	colored = false,
}

local filetype = {
	"filetype",
	colored = false,
	icons_enabled = false,
}

local fileformat = {
	"fileformat",
	symbols = {
		unix = " Unix", -- e712
		dos = " DOS", -- e70f
		mac = " MacOS", -- e711
	},
}

local macro = {
	"macro",
	fmt = function()
		local recording_register = vim.fn.reg_recording()
		if recording_register == "" then
			return ""
		else
			return "Recording @" .. recording_register
		end
	end,
}

local progress = {
	"progress",
	icon = "",
	separator = { left = "", right = "" },
}

local search_count = {
	"search_count",
	icon = "",
	fmt = function()
		local results = vim.fn.searchcount({ maxcount = 0 })
		local noh = vim.opt.hlsearch._value
		if results.total > 0 then
			return results.current .. "," .. results.total
		end
	end,
}

local selection_count = {
	"selection_count",
	icon = "󰾂",
	fmt = function()
		local isVisualMode = vim.fn.mode():find("[Vv]")
		if not isVisualMode then
			return ""
		end

		local starts = vim.fn.line("v")
		local ends = vim.fn.line(".")
		local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
		local chars = vim.fn.wordcount().visual_chars

		return lines .. "L " .. chars .. "C"
	end,
}

local buffers = {
	"buffers",
	fmt = function(str)
		return str
	end,
	show_filename_only = true,
	show_modified_status = true,

	max_length = function()
		return vim.o.columns
	end,
	filetype_names = {
		TelescopePrompt = "Telescope",
		dashboard = "Dashboard",
		packer = "Packer",
		fzf = "FZF",
		lazy = "Lazy",
	},

	use_mode_colors = true,

	buffers_color = {
		inactive = { bg = colors.bg, fg = colors.grey },
	},

	separator = { left = "", right = "" },
	section_separators = { left = "", right = "" },

	symbols = { alternate_file = "" },
}

require("lualine").setup({
	options = {
		fmt = string.upper,
		theme = wally,
		component_separators = { left = "/", right = "/" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch },
		lualine_c = { diff, macro },
		-- lualine_x = { diagnostics, lsp_clients },
		lualine_x = { diagnostics },
		lualine_y = { "filesize", filetype, fileformat, selection_count, search_count },
		lualine_z = { progress },
	},
	inactive_sections = {},
	tabline = {
		lualine_a = { buffers },
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
