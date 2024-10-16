local wezterm = require("wezterm")

return {
	keys = {
		{
			key = "F11",
			mods = "NONE",
			action = wezterm.action.ToggleFullScreen,
		},
	},
	hide_tab_bar_if_only_one_tab = true, -- Hide tab bar if there's only one tab
	scrollback_lines = 10000,
	window_decorations = "NONE | RESIZE",

	-- Vague.nvim-inspired theme colors
	color_scheme = "Vague", -- Assuming you have a color scheme named Vague
	colors = {
		background = "#18191a",
		foreground = "#abb2bf",
		cursor_bg = "#61afef",
		cursor_fg = "#282c34",
		cursor_border = "#61afef",

		-- Modify the colors to use valid keys
		ansi = {
			"#282c34", -- black
			"#e06c75", -- red
			"#98c379", -- green
			"#e5c07b", -- yellow
			"#61afef", -- blue
			"#c678dd", -- magenta
			"#56b6c2", -- cyan
			"#ffffff", -- white
		},
		brights = {
			"#5c6370", -- bright black
			"#e06c75", -- bright red
			"#98c379", -- bright green
			"#e5c07b", -- bright yellow
			"#61afef", -- bright blue
			"#c678dd", -- bright magenta
			"#56b6c2", -- bright cyan
			"#ffffff", -- bright white
		},
	},

	-- Font settings (adjust as needed)
	font = wezterm.font("JetBrains Mono"), -- Change this to your preferred font
	font_size = 12.0, -- Adjust the font size
	line_height = 1.2, -- Adjust the line height
}
