local wezterm = require("wezterm")
local config = {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"Noto Sans CJK JP",
	}),
	font_size = 10,
	colors = { cursor_bg = "white" },
	line_height = 1.2,
	default_cursor_style = "SteadyBar",
	cursor_blink_ease_out = { CubicBezier = { 0.0, 0.0, 0, 0 } },
	cursor_blink_ease_in = { CubicBezier = { 0.0, 0.0, 0, 0 } },
	cursor_blink_rate = 600,
	enable_tab_bar = false,
	window_background_opacity = 1,
	window_padding = {
		left = 15,
		right = 15,
		top = 15,
		bottom = 15,
	},
	adjust_window_size_when_changing_font_size = false,

	keys = {
		{ key = "Space", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	},
}

return config
