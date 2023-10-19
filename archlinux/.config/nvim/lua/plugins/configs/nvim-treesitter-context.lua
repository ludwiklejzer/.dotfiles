local options = {
	enable = true,
	max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
	min_window_height = 20, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	line_numbers = true,
	multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
	trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
	zindex = 20, -- The Z-index of the context window
	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

local hl = vim.api.nvim_set_hl

hl(0, "TreesitterContext", { bg = "#f2f1ed", italic = true })
hl(0, "TreesitterContextBottom", { bg = "#f2f1ed", italic = true })
hl(0, "TreesitterContextLineNumber", { bg = "#f2f1ed", italic = true })

return options
