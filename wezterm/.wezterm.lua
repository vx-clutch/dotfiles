local wezterm = require("wezterm")

local config = {}

if wezterm.target_triple:find("windows") then
	config.default_prog = { "wsl.exe", "-d", "Fedora", "--cd", "~" }
	config.keys = {
		{
			key = "F11",
			mods = "NONE",
			action = wezterm.action.ToggleFullScreen,
		},
	}
end

config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.color_scheme = "vx-rose-pine"

config.color_schemes = {
	["vx-rose-pine"] = {
		foreground = "#e0def4",
		background = "#000000",
		cursor_bg = "#e0def4",
		cursor_border = "#e0def4",
		cursor_fg = "#191724",
		selection_bg = "#524f67",
		selection_fg = "#e0def4",
		ansi = {
			"#191724", -- Base
			"#eb6f92", -- Love
			"#f6c177", -- Gold
			"#ebbcba", -- Rose
			"#9ccfd8", -- Pine
			"#c4a7e7", -- Iris
			"#31748f", -- Foam
			"#e0def4", -- Text
		},
		brights = {
			"#6e6a86", -- Subtle
			"#eb6f92", -- Love
			"#f6c177", -- Gold
			"#ebbcba", -- Rose
			"#9ccfd8", -- Pine
			"#c4a7e7", -- Iris
			"#31748f", -- Foam
			"#e0def4", -- Text
		},
	},
}

config.font = wezterm.font("Iosevka Slab")
config.font_size = 20.0

return config
