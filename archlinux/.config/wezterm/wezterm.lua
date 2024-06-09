local wezterm = require("wezterm")

local catppuccin = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
catppuccin.background = "#111111"

local config = {
	font = wezterm.font_with_fallback({
		"JetBrainsMono",
		-- "RobotoMono Nerd Font",
		-- "CartographCF Nerd Font",
		-- "CaskaydiaCove Nerd Font Propo",
		"Noto Sans CJK JP",
	}),
	freetype_load_flags = "NO_HINTING",
	font_size = 11.5,
	force_reverse_video_cursor = true,
	line_height = 1,
	cell_width = 0.9,
	color_schemes = { ["My Catppuccin"] = catppuccin },
	color_scheme = "Gruvbox Material (Gogh)",
	default_cursor_style = "SteadyBar",
	cursor_blink_ease_out = { CubicBezier = { 0.0, 0.0, 0, 0 } },
	cursor_blink_ease_in = { CubicBezier = { 0.0, 0.0, 0, 0 } },
	cursor_blink_rate = 600,
	enable_tab_bar = false,
	window_background_opacity = 1,
	window_padding = {},
	adjust_window_size_when_changing_font_size = false,
	keys = {
		{ key = "Space", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "7",
			mods = "CTRL",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "v" }),
				wezterm.action.SendKey({ key = "Enter" }),
			}),
		},
		{
			key = "8",
			mods = "CTRL",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "Space" }),
				wezterm.action.SendKey({ key = "w" }),
				wezterm.action.SendKey({ key = "w" }),
			}),
		},
	},
	window_background_gradient = {
		-- Can be "Vertical" or "Horizontal".  Specifies the direction
		-- in which the color gradient varies.  The default is "Horizontal",
		-- with the gradient going from left-to-right.
		-- Linear and Radial gradients are also supported; see the other
		-- examples below
		orientation = "Vertical",
		colors = {
			"rgba(27,27,27, 1)",
			"rgba(27,27,27, 0.65)",
		},
		interpolation = "Linear",
		blend = "Rgb",
		noise = 64,
	},
}

return config
