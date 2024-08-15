local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.default_domain = 'WSL:Fedora'

config.color_scheme = "Solarized Dark - Patched"

return config
