---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
    theme = "tomorrow_night",
    theme_toggle = { "tomorrow_night", "everforest_light" },

    hl_override = highlights.override,
    hl_add = highlights.add,
    statusline = {
        theme = "vscode_colored",
    },
    changed_themes = {
        everforest_light = {
            base_30 = {
                statusline_bg = "#ffffff",
                one_bg3 = "#f9f9ff",
            },
        },
        tomorrow_night = {
            base_30 = {
                statusline_bg = "#222211",
                one_bg3 = "#111100",
            },
        },
    },
    telescope = {
        style = "bordered",
    },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
