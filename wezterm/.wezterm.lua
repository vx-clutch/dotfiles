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

config.font = wezterm.font("ComicShannsMono Nerd Font")
config.font_size = 20.0

local TARGET_ROWS = 25
wezterm.on("window-config-reloaded", function(window, pane)
  local dims = window:get_dimensions()
  local pixel_height = dims.pixel_height

  local line_height = config.line_height or 1.2
  local font_size = (pixel_height / TARGET_ROWS) / line_height

  window:set_config_overrides({
    font_size = font_size,
  })
end)
config.line_height = 1.2

return config
