local utils = require("core.utils")
local get_hl_fg = utils.get_hl_fg

local my_theme = {
	normal = {
		a = { bg = "NONE", fg = "#888888" },
		b = { bg = "NONE", fg = "#888888" },
		c = { bg = "NONE", fg = "#888888" },
		x = { bg = "NONE", fg = "#888888" },
		y = { bg = "NONE", fg = "#EEEEEE" },
		z = { bg = "NONE", fg = "#888888" },
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
	separator = { left = "", right = "" },
	fmt = function(str)
		if str == "NORMAL" then
			return ""
		elseif str == "INSERT" then
			return "󰣕"
		elseif str == "VISUAL" then
			return "󰕢"
		elseif str == "V-LINE" then
			return "󰘤"
		elseif str == "V-BLOCK" then
			return "󰩭"
		elseif str == "REPLACE" then
			return "󰛔"
		elseif str == "COMMAND" then
			return ""
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
	icon = "",
}

local filetype = {
	"filetype",
	colored = false,
	icons_enabled = true,
}

local fileformat = {
	"fileformat",
	cond = function()
		if vim.api.nvim_get_option("fileformat") == "dos" then
			return true
		elseif vim.api.nvim_get_option("fileformat") == "mac" then
			return true
		end
	end,
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

local line_sep = {
	"line_sep",
	fmt = function()
		local width = vim.api.nvim_win_get_width(0)

		return string.rep("─", width - 2)
	end,
	color = { bg = "NONE", fg = "#333333" },
}

local progress = {
	"progress",
	icon = "",
	separator = { left = "", right = "" },
}

local searchcount = {
	"searchcount",
	icon = "",
}

local lazy_updates = {
	"lazy_updates",
	fmt = function()
		return "󱧕"
	end,
	cond = require("lazy.status").has_updates,
	color = { fg = "#ff9e64" },
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
		inactive = { bg = "NONE", fg = "#444444" },
		active = { bg = "NONE", fg = "#AAAAAA", gui = "bold" },
	},
}

require("lualine").setup({
	options = {
		fmt = string.upper,
		theme = my_theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "alpha", "NvimTree", "TelescopePrompt", "lazy", "mason", "help" },
			winbar = {
				"alpha",
				"NvimTree",
				"TelescopePrompt",
				"lazy",
				"mason",
				"qf",
				"help",
				"term",
				"dap-repl",
				-- "dapui_scopes",
				"dapui_breakpoints",
				"dapui_stacks",
				"dapui_watches",
				"dapui_console",
			},
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
		lualine_a = { lazy_updates },
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "%s", macro, selection_count, searchcount },
		lualine_y = { diagnostics },
		lualine_z = { branch, fileformat, mode },
	},
	tabline = {
		lualine_a = { buffers },
		lualine_z = {},
	},
	winbar = {
		lualine_a = { line_sep },
	},
	inactive_sections = {},
	inactive_winbar = {
		lualine_a = { line_sep },
	},
	extensions = {},
})
