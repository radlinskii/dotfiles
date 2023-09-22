-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors
local M = {}

---@type Base46HLGroupsList
M.override = {
    Comment = {
        italic = true,
    },
    TelescopeBorder = {
        fg = "white",
        bg = "darker_black",
    },
    TelescopePromptBorder = {
        fg = "white",
        bg = "darker_black",
    },
    StText = {
        fg = "light_grey",
    },
    St_VisualMode = {
        bg = "statusline_bg",
    },
    St_NormalMode = {
        bg = "statusline_bg",
    },
    St_InsertMode = {
        bg = "statusline_bg",
    },
    St_TerminalMode = {
        bg = "statusline_bg",
    },
    St_NTerminalMode = {
        bg = "statusline_bg",
    },
    St_ReplaceMode = {
        bg = "statusline_bg",
    },
    St_ConfirmMode = {
        bg = "statusline_bg",
    },
    St_CommandMode = {
        bg = "statusline_bg",
    },
    St_SelectMode = {
        bg = "statusline_bg",
    },
    St_cwd = {
        bg = "statusline_bg",
    },
    NvDashAscii = {
        fg = "darker_black",
        bg = "white",
    },
}

---@type HLTable
M.add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },

    GitSignsChange = {
        fg = "blue",
    },
    GitSignsDeleteChange = {
        fg = "purple",
    },
}

return M
