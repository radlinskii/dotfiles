local M = {}

M.get_dark_theme = function()
    local kanagawa_theme = require("kanagawa.colors").setup().theme

    local theme = {}

    theme.normal = {
        a = { bg = kanagawa_theme.syn.fun, fg = kanagawa_theme.ui.bg_m3 },
        b = { bg = kanagawa_theme.ui.fg_reverse, fg = kanagawa_theme.syn.fun },
        c = { bg = kanagawa_theme.ui.bg_p1, fg = kanagawa_theme.ui.fg },
    }

    theme.insert = {
        a = { bg = kanagawa_theme.diag.ok, fg = kanagawa_theme.ui.bg },
        b = { bg = kanagawa_theme.diff.add, fg = kanagawa_theme.diag.ok },
    }

    theme.command = {
        a = { bg = kanagawa_theme.syn.operator, fg = kanagawa_theme.ui.bg },
        b = { bg = kanagawa_theme.diff.text, fg = kanagawa_theme.syn.operator },
    }

    theme.visual = {
        a = { bg = kanagawa_theme.syn.keyword, fg = kanagawa_theme.ui.bg },
        b = { bg = "#352F48", fg = kanagawa_theme.syn.keyword },
    }

    theme.replace = {
        a = { bg = kanagawa_theme.syn.constant, fg = kanagawa_theme.ui.bg },
        b = { bg = kanagawa_theme.diff.text, fg = kanagawa_theme.syn.constant },
    }

    theme.inactive = {
        a = { bg = kanagawa_theme.ui.bg_m3, fg = kanagawa_theme.ui.fg_dim },
        b = { bg = kanagawa_theme.ui.bg_m3, fg = kanagawa_theme.ui.fg_dim, gui = "bold" },
        c = { bg = kanagawa_theme.ui.bg_m3, fg = kanagawa_theme.ui.fg_dim },
    }

    return theme
end

M.get_light_theme = function()
    local kanagawa_theme = require("kanagawa.colors").setup().theme

    local theme = {}

    theme.normal = {
        a = { bg = kanagawa_theme.syn.fun, fg = kanagawa_theme.ui.bg_m3 },
        b = { bg = kanagawa_theme.diff.change, fg = kanagawa_theme.syn.fun },
        c = { bg = kanagawa_theme.ui.bg_p2, fg = kanagawa_theme.ui.fg },
    }

    theme.insert = {
        a = { bg = kanagawa_theme.diag.ok, fg = kanagawa_theme.ui.bg },
        -- b = { bg = kanagawa_theme.diff.add, fg = kanagawa_theme.diag.ok },
        b = { bg = "#cfe3bf", fg = kanagawa_theme.diag.ok },
    }

    theme.command = {
        a = { bg = kanagawa_theme.syn.operator, fg = kanagawa_theme.ui.bg },
        b = { bg = kanagawa_theme.ui.bg_m3, fg = kanagawa_theme.syn.operator },
    }

    theme.visual = {
        a = { bg = kanagawa_theme.syn.keyword, fg = kanagawa_theme.ui.bg },
        b = { bg = kanagawa_theme.ui.bg_visual, fg = kanagawa_theme.syn.keyword },
    }

    theme.replace = {
        a = { bg = kanagawa_theme.syn.constant, fg = kanagawa_theme.ui.bg },
        b = { bg = kanagawa_theme.diff.text, fg = kanagawa_theme.syn.constant },
    }

    theme.inactive = {
        a = { bg = kanagawa_theme.ui.bg_m3, fg = kanagawa_theme.ui.fg_dim },
        b = { bg = kanagawa_theme.ui.bg_m3, fg = kanagawa_theme.ui.fg_dim, gui = "bold" },
        c = { bg = kanagawa_theme.ui.bg_m3, fg = kanagawa_theme.ui.fg_dim },
    }

    return theme
end

return M
