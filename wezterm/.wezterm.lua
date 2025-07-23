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

config.font = wezterm.font("Iosevka Slab")
config.font_size = 20.0

return config
