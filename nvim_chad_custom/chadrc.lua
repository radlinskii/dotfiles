---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
    theme = "penumbra_light",
    theme_toggle = { "tomorrow_night", "penumbra_light" },

    hl_override = highlights.override,
    hl_add = highlights.add,
    statusline = {
        theme = "vscode_colored",
    },
    changed_themes = {
        penumbra_light = {
            base_30 = {
                statusline_bg = "#eeeecc",
            },
            base_16 = {
                base09 = "#be9e00",
            },
            polish_hl = {
                ["@field"] = {
                    fg = "#dd7777",
                },
                ["@constant"] = {
                    fg = "#992222",
                },
            },
        },
        tomorrow_night = {
            base_30 = {
                statusline_bg = "#2d2d22",
            },
            polish_hl = {
                ["@field"] = {
                    fg = "#dd8877",
                },
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
