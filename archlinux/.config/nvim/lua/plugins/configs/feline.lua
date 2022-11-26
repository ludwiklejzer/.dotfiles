local feline = require("feline")
local lsp = require("feline.providers.lsp")
local pywal_feline = require("pywal.feline")
local vi_mode_utils = require("feline.providers.vi_mode")
local pywal_core = require("pywal.core")
local pywal_colors = pywal_core.get_colors()

local components = {
	active = { {}, {} },
	inactive = {
		{
			provider = " ",
			hl = "InactiveStatusHL",
		},
	},
}

local disabled_buffers = {
	filetypes = {
		"^NvimTree$",
		"^packer$",
		"^startify$",
		"^fugitive$",
		"^fugitiveblame$",
		"^qf$",
		"^help$",
	},
	buftypes = {
		"^terminal$",
	},
	bufnames = {},
}

local theme = {
	bg = pywal_colors.background,
	fg = pywal_colors.foreground,
	black = pywal_colors.color0,
	red = pywal_colors.color1,
	green = pywal_colors.color2,
	yellow = pywal_colors.color3,
	blue = pywal_colors.color4,
	magenta = pywal_colors.color5,
	cyan = pywal_colors.color6,
	grey = pywal_colors.color7,
}

local separator = {
	str = " / ",
	hl = {
		fg = theme.red,
	},
}

-- LEFT COMPONENTS
components.active[1][1] = {
	provider = function()
		return "  " .. vi_mode_utils.get_vim_mode()
	end,
	hl = function()
		return {
			name = vi_mode_utils.get_mode_highlight_name(),
			fg = vi_mode_utils.get_mode_color(),
			style = "bold",
		}
	end,
}

-- gitBranch
components.active[1][2] = {
	provider = "git_branch",
	hl = {
		fg = theme.magenta,
		style = "bold",
	},
	left_sep = separator,
	right_sep = {
		str = " - ",
		hl = {
			fg = theme.red,
		},
	},
}

-- diffAdd
components.active[1][3] = {
	provider = "git_diff_added",
	hl = {
		name = "diff_added_hl",
		style = "bold",
	},
	icon = {
		str = " ",
		hl = { fg = theme.green },
	},
}

-- diffModfified
components.active[1][4] = {
	provider = "git_diff_changed",
	hl = {
		name = "diff_changed_hl",
		style = "bold",
	},
	icon = {
		str = "  ",
		hl = { fg = theme.blue },
	},
}
-- diffRemove
components.active[1][5] = {
	provider = "git_diff_removed",
	hl = {
		name = "diff_removed_hl",
		style = "bold",
	},
	icon = {
		str = "  ",
		hl = { fg = theme.red },
	},
}

-- RIGHT COMPONENTS

-- diagnosticErrors
components.active[2][1] = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
	end,
	hl = {
		style = "bold",
	},
	icon = {
		str = " ",
		hl = { fg = theme.red },
	},
}

-- diagnosticWarn
components.active[2][2] = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
	end,
	hl = {
		style = "bold",
	},
	icon = {
		str = " ",
		hl = { fg = theme.red },
	},
	left_sep = " ",
}

-- diagnosticHint
components.active[2][3] = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
	end,
	hl = {
		style = "bold",
	},
	icon = {
		str = " ",
		hl = { fg = theme.red },
	},
	left_sep = " ",
}

-- diagnosticInfo
components.active[2][4] = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
	end,
	hl = {
		style = "bold",
	},
	icon = {
		str = " ",
		hl = { fg = theme.red },
	},
	left_sep = " ",
}

-- Name of LSP clients attached to current buffer
components.active[2][4] = {
	provider = "lsp_client_names",
	hl = {
		name = "lsp_clients_hl",
		style = "bold",
	},
	right_sep = separator,
	left_sep = separator,
	icon = {
		str = "煉",
		hl = { fg = theme.red },
	},
}

-- Buffers encoding (UTF-8, UTF-16...)
components.active[2][5] = {
	provider = "file_encoding",
	hl = {
		name = "file_encoding_hl",
		style = "bold",
	},
	right_sep = {
		str = ":",
		hl = {
			fg = theme.foreground,
			style = "bold",
		},
	},
	icon = {
		str = " ",
		hl = { fg = theme.red },
	},
}
components.active[2][6] = {
	provider = "file_format",
	hl = {
		name = "file_encoding_hl",
		style = "bold",
	},
	right_sep = separator,
}

components.active[2][7] = {
	provider = "line_percentage",
	hl = {
		name = "line_percentage_hl",
		style = "bold",
	},
	icon = {
		str = " ",
		hl = { fg = theme.red },
	},
}

feline.setup({
	theme = theme,
	components = components,
	disable = disabled_buffers,
})
