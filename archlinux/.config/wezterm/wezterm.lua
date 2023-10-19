local wezterm = require("wezterm")
local config = {
	font = wezterm.font_with_fallback({
		"CartographCF Nerd Font",
		-- "JetBrainsMono Nerd Font",
		"Noto Sans CJK JP",
	}, { weight = "Regular", style = "Normal" }),
	font_size = 10,
	colors = {
		background = "#ffffff",
		foreground = "#333333",
		cursor_bg = "#333333",
		cursor_fg = "#ffffff",
		cursor_border = "#333333",
		selection_bg = "#dae9f9",
		-- selection_fg = "#ffffff",
		ansi = {
			"#000000",
			"#cb2431",
			"#22863a",
			"#d0b92d",
			"#0366d6",
			"#9333ea",
			"#005cc5",
			"#ffffff",
		},
		brights = {
			"#6a737d",
			"#d73a49",
			"#28a745",
			"#f0c724",
			"#2188ff",
			"#8a63d2",
			"#0d66d6",
			"#ffffff",
		},
	},
	line_height = 1.1,
	default_cursor_style = "SteadyBar",
	cursor_blink_ease_out = { CubicBezier = { 0.0, 0.0, 0, 0 } },
	cursor_blink_ease_in = { CubicBezier = { 0.0, 0.0, 0, 0 } },
	cursor_blink_rate = 600,
	enable_tab_bar = false,
	window_background_opacity = 1,
	window_padding = {
		-- left = 20,
		-- right = 20,
		-- top = 20,
		-- bottom = 20,

		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	adjust_window_size_when_changing_font_size = false,
	keys = {
		{ key = "Space", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	},
}

return config
