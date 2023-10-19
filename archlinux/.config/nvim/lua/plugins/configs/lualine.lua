local retrolight = {
	normal = {
		a = { bg = "#222222", fg = "#DCDAD5" },
		b = { bg = "#222222", fg = "#DCDAD5" },
		c = { bg = "#222222", fg = "#DCDAD5" },
		x = { bg = "#222222", fg = "#DCDAD5" },
		y = { bg = "#222222", fg = "#DCDAD5" },
		z = { bg = "#222222", fg = "#DCDAD5" },
	},
	-- insert = {
	-- 	a = { bg = "#222222", fg = "#DCDAD5" },
	-- 	b = { bg = "#222222", fg = "#DCDAD5" },
	-- 	c = { bg = "#222222", fg = "#DCDAD5" },
	-- 	x = { bg = "#222222", fg = "#DCDAD5" },
	-- 	y = { bg = "#222222", fg = "#DCDAD5" },
	-- 	z = { bg = "#222222", fg = "#DCDAD5" },
	-- },
	-- visual = {
	-- 	a = { bg = "#222222", fg = "#DCDAD5" },
	-- 	b = { bg = "#222222", fg = "#DCDAD5" },
	-- 	c = { bg = "#222222", fg = "#DCDAD5" },
	-- 	x = { bg = "#222222", fg = "#DCDAD5" },
	-- 	y = { bg = "#222222", fg = "#DCDAD5" },
	-- 	z = { bg = "#222222", fg = "#DCDAD5" },
	-- },
	-- replace = {
	-- 	a = { bg = "#222222", fg = "#DCDAD5" },
	-- 	b = { bg = "#222222", fg = "#DCDAD5" },
	-- 	c = { bg = "#222222", fg = "#DCDAD5" },
	-- 	x = { bg = "#222222", fg = "#DCDAD5" },
	-- 	y = { bg = "#222222", fg = "#DCDAD5" },
	-- 	z = { bg = "#222222", fg = "#DCDAD5" },
	-- },
	-- command = {
	-- 	a = { bg = "#222222", fg = "#DCDAD5" },
	-- 	b = { bg = "#222222", fg = "#DCDAD5" },
	-- 	c = { bg = "#222222", fg = "#DCDAD5" },
	-- 	x = { bg = "#222222", fg = "#DCDAD5" },
	-- 	y = { bg = "#222222", fg = "#DCDAD5" },
	-- 	z = { bg = "#222222", fg = "#DCDAD5" },
	-- },
	-- inactive = {
	-- 	a = { bg = "#222222", fg = "#DCDAD5" },
	-- 	b = { bg = "#222222", fg = "#DCDAD5" },
	-- 	c = { bg = "#222222", fg = "#DCDAD5" },
	-- 	x = { bg = "#222222", fg = "#DCDAD5" },
	-- 	y = { bg = "#222222", fg = "#DCDAD5" },
	-- 	z = { bg = "#222222", fg = "#DCDAD5" },
	-- },
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
	separator = { left = "", right = "" },
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

local filesize = {
	"filesize",
}

local filetype = {
	"filetype",
	colored = false,
	icons_enabled = true,
}

local fileformat = {
	"fileformat",
	symbols = {
		unix = " Unix", -- e712
		dos = "󰨡 DOS", -- e70f
		mac = " MacOS", -- e711
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
	separator = { left = "", right = "" },
}

local searchcount = {
	"searchcount",
	icon = "",
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

local navic = {
	"navic",
	-- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
	-- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
	-- Setting it to "static" will perform a adjustment once when the component is being setup. This should
	--   be enough when the lualine section isn't changing colors based on the mode.
	-- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
	--   the current section.
	-- color_correction = nil,
	color_correction = "static",

	navic_opts = {
		icons = {
			File = "󰈙 ",
			Module = " ",
			Namespace = "󰌗 ",
			Package = " ",
			Class = "󰌗 ",
			Method = "󰆧 ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = "󰕘",
			Interface = "󰕘",
			Function = "󰊕 ",
			Variable = "󰆧 ",
			Constant = "󰏿 ",
			String = "󰀬 ",
			Number = "󰎠 ",
			Boolean = "◩ ",
			Array = "󰅪 ",
			Object = "󰅩 ",
			Key = "󰌋 ",
			Null = "󰟢 ",
			EnumMember = " ",
			Struct = "󰌗 ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = "󰊄 ",
		},
		highlight = false,
		separator = " > ",
		depth_limit = 0,
		depth_limit_indicator = "..",
		safe_output = true,
		lazy_update_context = false,
		click = false,
	},
}

local buffers = {
	"buffers",
	fmt = function(str)
		return str
	end,
	show_filename_only = true,
	show_modified_status = true,
	component_separators = { left = "", right = "" },
	symbols = { alternate_file = "" },
	use_mode_colors = true,

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

	buffers_color = {
		inactive = { bg = "#DCDAD5", fg = "#AAAAAA" },
		active = { bg = "#DCDAD5", fg = "#222222" },
	},
}

require("lualine").setup({
	options = {
		fmt = string.upper,
		theme = retrolight,
		component_separators = { left = "/", right = "/" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { statusline = {}, winbar = {} },
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
		lualine_a = { navic },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = { mode },
		lualine_b = { branch },
		lualine_c = { diff, macro },
		-- lualine_x = { diagnostics, lsp_clients },
		lualine_x = { diagnostics },
		lualine_y = { filesize, filetype, fileformat, selection_count, searchcount },
		lualine_z = { progress },
	},
	winbar = {
		lualine_a = { buffers },
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
})
