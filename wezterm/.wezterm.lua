local wezterm = require "wezterm"

local config = wezterm.config_builder()

if wezterm.target_triple:find("windows") then
    config.default_prog = { 'wsl.exe', '-d', 'Fedora', '--cd', '~' }
    config.keys = {
        {
            key = 'F11',
            mods = 'NONE',
            action = wezterm.action.ToggleFullScreen,
        },
    }
end

config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.color_scheme = "Vague"
config.colors = {
    background = '#18191a',
    foreground = '#abb2bf',
    cursor_bg = '#61afef',
    cursor_fg = '#282c34',
    cursor_border = '#61afef',

    ansi = {
        '#282c34',  -- black
        '#e06c75',  -- red
        '#98c379',  -- green
        '#e5c07b',  -- yellow
        '#61afef',  -- blue
        '#c678dd',  -- magenta
        '#56b6c2',  -- cyan
        '#ffffff',  -- white
    },
    brights = {
        '#5c6370',  -- bright black
        '#e06c75',  -- bright red
        '#98c379',  -- bright green
        '#e5c07b',  -- bright yellow
        '#61afef',  -- bright blue
        '#c678dd',  -- bright magenta
        '#56b6c2',  -- bright cyan
        '#ffffff',  -- bright white
    },
}

config.font = wezterm.font("Iosevka Slab")  -- Change this to your preferred font
config.font_size = 24.0  -- Adjust the font size
config.line_height = 1.2  -- Adjust the line height

return config
