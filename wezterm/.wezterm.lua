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

-- Adjusted colors for similarity to the image
config.colors = {
    background = '#000000', -- Darker background
    foreground = '#c0caf5', -- Light foreground
    cursor_bg = '#c0caf5',  -- Cursor color
    cursor_fg = '#0f111a',
    cursor_border = '#c0caf5',

    ansi = {
        '#32344a',  -- black
        '#f7768e',  -- red
        '#9ece6a',  -- green
        '#e0af68',  -- yellow
        '#7aa2f7',  -- blue
        '#bb9af7',  -- magenta
        '#7dcfff',  -- cyan
        '#a9b1d6',  -- white
    },
    brights = {
        '#444b6a',  -- bright black
        '#ff7a93',  -- bright red
        '#b9f27c',  -- bright green
        '#ff9e64',  -- bright yellow
        '#7da6ff',  -- bright blue
        '#c69ff7',  -- bright magenta
        '#7dcfff',  -- bright cyan
        '#c0caf5',  -- bright white
    },
}

config.font = wezterm.font("Iosevka") -- Match font as close as possible
config.font_size = 18.0 -- Slightly reduced size for a compact view
config.line_height = 1.1 -- Adjusted line height

return config
