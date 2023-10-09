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
    ---@diagnostic disable missing-fields
    changed_themes = {
        penumbra_light = {
            base_30 = {
                statusline_bg = "#eeeecc",
            },
            base_16 = {
                base09 = "#be9e00",
            },
            polish_hl = {
                ["@field"] = { fg = "#dd7777" },
                ["@constant"] = { fg = "#992222" },
                DiffAdd = { fg = "NONE", bg = "#dcffdc", underline = false },
                DiffDelete = { fg = "NONE", bg = "#ffdfdf", underline = false },
                DiffChange = { fg = "NONE", bg = "#e3f3ff", underline = false },
                DiffChangeDelete = { fg = "NONE", bg = "#efcfff", underline = false },
                DiffText = { fg = "NONE", bg = "#cadfff" },
                NvDashAscii = {
                    fg = "#1182dc",
                    bg = "#4b4033",
                },
                IndentBlanklineContextChar = {
                    fg = "#22839b",
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
                ["@field"] = { fg = "#dd8877" },
                DiffAdd = { fg = "NONE", bg = "#334433", underline = false },
                DiffDelete = { fg = "NONE", bg = "#442222", underline = false },
                DiffChange = { fg = "NONE", bg = "#223344", underline = false },
                DiffChangeDelete = { fg = "NONE", bg = "#221133", underline = false },
                DiffText = { fg = "NONE", bg = "#445577" },
                NvDashAscii = {
                    fg = "#32e548",
                    bg = "#1b1000",
                },
                IndentBlanklineContextChar = {
                    fg = "#22839b",
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
