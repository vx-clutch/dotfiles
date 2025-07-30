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

config.enable_tab_bar = false
config.window_padding = {
	left = 15,
	right = 15,
	top = 15,
	bottom = 15,
}

config.font = wezterm.font("ComicShannsMono Nerd Font")
config.font_size = 20.0

config.front_end = "WebGpu"
config.window_decorations = "RESIZE"

return config