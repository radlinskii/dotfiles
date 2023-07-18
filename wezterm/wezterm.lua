-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return 'Dark'
end

local function scheme_for_appearance(appearance)
    if appearance:find 'Dark' then
        return 'SpaceGray Eighties Dull'
    else
        return 'Ivory Light (terminal.sexy)'
    end
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = scheme_for_appearance(get_appearance())

local function common_tab_bar_colors()
    return {
        active_tab = {
            bg_color = '#2b2042',
            fg_color = '#efe0ef',
            italic = true,
            strikethrough = false,
        },
    }
end

local function colors_for_appearance(appearance)
    if appearance:find 'Dark' then
        return {
            -- The default text color
            foreground = '#d0d0d0',
            background = '#1b1b00',
            selection_fg = 'black',
            selection_bg = '#fffacd',
            tab_bar = common_tab_bar_colors(),
        }
    else
        return {
            -- The default text color
            foreground = '#303030',
            background = '#f8f1df',
            tab_bar = common_tab_bar_colors(),
        }
    end
end

config.colors = colors_for_appearance(get_appearance())

config.window_frame = {
    font = wezterm.font { family = 'Roboto', weight = 'Bold' },
    font_size = 14.0,
    active_titlebar_bg = '#22aa3f', -- not working as expected
    inactive_titlebar_bg = '#44996f',
}

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13.6

config.leader = { key = 'e', mods = 'CMD', timeout_milliseconds = 1000 }
config.keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    { key = "LeftArrow",  mods = "OPT", action = wezterm.action { SendString = "\x1bb" } },
    -- Make Option-Right equivalent to Alt-f; forward-word
    { key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bf" } },
    { key = "Backspace",  mods = "CMD", action = wezterm.action { SendString = "\x15" } },
    {
        key = 'i',
        mods = 'CMD',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '.',
        mods = 'CMD',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'c',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivateCopyMode,
    },
    {
        key = 'm',
        mods = 'CMD',
        action = wezterm.action.DisableDefaultAssignment,
    },
    {
        key = 'h',
        mods = 'CMD',
        action = wezterm.action.DisableDefaultAssignment,
    },
}

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config
