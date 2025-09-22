-- statusline
local function config()
	local my_theme = {
		normal = {
			a = { bg = "NONE", fg = "#888888" },
			b = { bg = "NONE", fg = "#888888" },
			c = { bg = "NONE", fg = "#888888" },
			x = { bg = "NONE", fg = "#888888" },
			y = { bg = "NONE", fg = "#EEEEEE" },
			z = { bg = "NONE", fg = "#888888" },
		},
		insert = {
			a = { bg = "NONE", fg = "#888888" },
			b = { bg = "NONE", fg = "#888888" },
			c = { bg = "NONE", fg = "#888888" },
			x = { bg = "NONE", fg = "#888888" },
			y = { bg = "NONE", fg = "#EEEEEE" },
			z = { bg = "NONE", fg = "#888888" },
		},
		inactive = {
			a = { bg = "NONE", fg = "#888888" },
			b = { bg = "NONE", fg = "#888888" },
			c = { bg = "NONE", fg = "#888888" },
			x = { bg = "NONE", fg = "#888888" },
			y = { bg = "NONE", fg = "#EEEEEE" },
			z = { bg = "NONE", fg = "#888888" },
		},
	}

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
		color = { bg = "NONE", fg = "#3a3e3e" },
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
			TelescopePrompt = " Telescope",
			lazy = " Lazy",
			["json.kulala_ui"] = "󰘦 Kulala JSON",
			["text.kulala_ui"] = " Kulala Text",
			["html.kulala_ui"] = " Kulala HTML",
			["kulala_verbose_result.kulala_ui"] = " Kulala Result",
			trouble = " Trouble",
			oil = "󰙅 Oil",
			qf = " Quickfix List",
			dapui_scopes = " DAP Scopes",
			dapui_breakpoints = " DAP Breakpoints",
			dapui_stacks = " DAP Stacks",
			dapui_watches = " DAP Watches",
			dapui_console = " DAP Console",
			["dap-repl"] = "󰆍 DAP repl",
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
			disabled_buftypes = {
				"terminal",
			},
			disabled_filetypes = {
				statusline = {
					"oil",
					"trouble",
					"alpha",
					"NvimTree",
					"TelescopePrompt",
					"lazy",
					"mason",
					"help",
				},
				tabline = {},
				winbar = {
					"alpha",
					"NvimTree",
					"TelescopePrompt",
					"lazy",
					"mason",
					-- "qf",
					-- "help",
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
				statusline = 600,
				tabline = 100,
				winbar = 100,
			},
		},
		sections = {
			lualine_a = { lazy_updates },
			lualine_b = {},
			lualine_c = {},
			lualine_x = { "%s", macro, selection_count, searchcount },
			lualine_y = { diagnostics },
			lualine_z = { branch, mode },
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
		extensions = { "trouble" },
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
