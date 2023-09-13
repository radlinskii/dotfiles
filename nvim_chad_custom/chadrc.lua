---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
    theme = "gruvbox",
    theme_toggle = { "gruvbox", "everforest_light" },

    hl_override = highlights.override,
    hl_add = highlights.add,
    statusline = {
        theme = "vscode_colored",
    },
    changed_themes = {
        everforest_light = {
            base_30 = {
                statusline_bg = "#555544",
                one_bg3 = "#222200",
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
