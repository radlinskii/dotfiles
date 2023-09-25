---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
    theme = "tomorrow_night",
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
            base_16 = {
                base00 = "#1b1b00",
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

    nvdash = {
        load_on_startup = true,

        header = {
            [[       ___           ___           ___                                    ___       ]],
            [[      /__/\         /  /\         /  /\          ___        ___          /__/\      ]],
            [[      \  \:\       /  /:/_       /  /::\        /__/\      /  /\        |  |::\     ]],
            [[       \  \:\     /  /:/ /\     /  /:/\:\       \  \:\    /  /:/        |  |:|:\    ]],
            [[   _____\__\:\   /  /:/ /:/_   /  /:/  \:\       \  \:\  /__/::\      __|__|:|\:\   ]],
            [[  /__/::::::::\ /__/:/ /:/ /\ /__/:/ \__\:\  ___  \__\:\ \__\/\:\__  /__/::::| \:\  ]],
            [[  \  \:\‾‾\‾‾\/ \  \:\/:/ /:/ \  \:\ /  /:/ /__/\ |  |:|    \  \:\/\ \  \:\‾‾\__\/  ]],
            [[   \  \:\  ‾‾‾   \  \::/ /:/   \  \:\  /:/  \  \:\|  |:|     \__\::/  \  \:\        ]],
            [[    \  \:\        \  \:\/:/     \  \:\/:/    \  \:\__|:|     /__/:/    \  \:\       ]],
            [[     \  \:\        \  \::/       \  \::/      \__\::::/      \__\/      \  \:\      ]],
            [[      \__\/         \__\/         \__\/           ‾‾‾                    \__\/      ]],
            [[                                                                                    ]],
        },

        buttons = {
            { " 󰈚  Recent Files", "<Space> f o  ", "Telescope oldfiles" },
            { "   Find File", "<Space> f f  ", "Telescope find_files" },
            { " 󰈭  Find Word", "<Space> f w  ", "Telescope live_grep" },
            { "   Git Status", "<Space> f g s", "Telescope git_status" },
            { "   Bookmarks", "<Space> f a  ", "Telescope marks" },
            { "   Themes", "<Space> , f  ", "Telescope themes" },
            { "   Mappings", "<Space> , m  ", "NvCheatsheet" },
            { " 󰮥  Help", "<Space> f h  ", "Telescope help_tags" },
        },
    },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
