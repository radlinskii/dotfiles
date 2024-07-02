---@type LazyPluginSpec
return {
    "m4xshen/hardtime.nvim",
    enabled = true,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        disable_mouse = false,
        resetting_keys = {
            ["j"] = { "n", "x" },
            ["k"] = { "n", "x" },
        },
        disabled_keys = {
            ["<Up>"] = { "" },
            ["<Down>"] = { "" },
            ["<Left>"] = { "" },
            ["<Right>"] = { "" },
        },
        disabled_filetypes = { "lazy" },
        hints = {
            -- j -> e, k -> u, h -> n, l -> i, i -> h, e -> l
            ["[ue][%^_]"] = {
                message = function(key)
                    return "Use " .. (key:sub(1, 1) == "u" and "-" or "<CR> or +") .. " instead of " .. key
                end,
                length = 2,
            },
            ["%$a"] = {
                message = function()
                    return "Use A instead of $a"
                end,
                length = 2,
            },
            ["d%$"] = {
                message = function()
                    return "Use D instead of d$"
                end,
                length = 2,
            },
            ["y%$"] = {
                message = function()
                    return "Use Y instead of y$"
                end,
                length = 2,
            },
            ["c%$"] = {
                message = function()
                    return "Use C instead of c$"
                end,
                length = 2,
            },
            ["%^h"] = {
                message = function()
                    return "Use H instead of ^h"
                end,
                length = 2,
            },
            ["%D[u-]o"] = {
                message = function(keys)
                    return "Use O instead of " .. keys:sub(2)
                end,
                length = 3,
            },
            ["%D[e+]O"] = {
                message = function(keys)
                    return "Use o instead of " .. keys:sub(2)
                end,
                length = 3,
            },
            ["[^fFtT]lh"] = {
                message = function()
                    return "Use a instead of lh"
                end,
                length = 3,
            },
            ["2([dcy=<>])%1"] = {
                message = function(key)
                    return "Use " .. key:sub(3) .. "e instead of " .. key
                end,
                length = 3,
            },

            -- hints for f/F/t/T
            ["[^dcy=]f.n"] = {
                message = function(keys)
                    return "Use t" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
                end,
                length = 4,
            },
            ["[^dcy=]F.i"] = {
                message = function(keys)
                    return "Use T" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
                end,
                length = 4,
            },
            ["[^dcy=]T.n"] = {
                message = function(keys)
                    return "Use F" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
                end,
                length = 4,
            },
            ["[^dcy=]t.i"] = {
                message = function(keys)
                    return "Use f" .. keys:sub(3, 3) .. " instead of " .. keys:sub(2)
                end,
                length = 4,
            },

            -- hints for delete + insert
            ["d[bBwWlL%^%$]h"] = {
                message = function(keys)
                    return "Use " .. "c" .. keys:sub(2, 2) .. " instead of " .. keys
                end,
                length = 3,
            },
            ["dg[lL]h"] = {
                message = function(keys)
                    return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 4,
            },
            ["d[tTfF].h"] = {
                message = function(keys)
                    return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 4,
            },
            ["d[ha][\"'`{}%[%]()<>bBwWspt]h"] = {
                message = function(keys)
                    return "Use " .. "c" .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 4,
            },

            -- hints for unnecessary visual mode
            ["Vgg[dcy=<>]"] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 4) .. "gg instead of " .. keys
                end,
                length = 4,
            },
            ['Vgg".[dy]'] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 6) .. "gg instead of " .. keys
                end,
                length = 6,
            },
            ["VG[dcy=<>]"] = {
                message = function(keys)
                    return "Use " .. keys:sub(3, 3) .. "G instead of " .. keys
                end,
                length = 3,
            },
            ['VG".[dy]'] = {
                message = function(keys)
                    return "Use " .. keys:sub(3, 5) .. "G instead of " .. keys
                end,
                length = 5,
            },
            ["V%d[ue][dcy=<>]"] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 4) .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 4,
            },
            ['V%d[ue]".[dy]'] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 6) .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 6,
            },
            ["V%d%d[ue][dcy=<>]"] = {
                message = function(keys)
                    return "Use " .. keys:sub(5, 5) .. keys:sub(2, 4) .. " instead of " .. keys
                end,
                length = 5,
            },
            ['V%d%d[ue]".[dy]'] = {
                message = function(keys)
                    return "Use " .. keys:sub(5, 7) .. keys:sub(2, 4) .. " instead of " .. keys
                end,
                length = 7,
            },
            ["[vV][bBwWlL%^%$][dcy=<>]"] = {
                message = function(keys)
                    return "Use " .. keys:sub(3, 3) .. keys:sub(2, 2) .. " instead of " .. keys
                end,
                length = 3,
            },
            ['[vV][bBwWlL%^%$]".[dy]'] = {
                message = function(keys)
                    return "Use " .. keys:sub(3, 5) .. keys:sub(2, 2) .. " instead of " .. keys
                end,
                length = 5,
            },
            ["[vV]g[lL][dcy=<>]"] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 4) .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 4,
            },
            ['[vV]g[lL]".[dy]'] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 6) .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 6,
            },
            ["[vV][tTfF].[dcy=<>]"] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 4) .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 4,
            },
            ['[vV][tTfF].".[dy]'] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 6) .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 6,
            },
            ["[vV][ha][\"'`{}%[%]()<>bBwWspt][dcy=<>]"] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 4) .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 4,
            },
            ['[vV][ha]["\'`{}%[%]()<>bBwWspt]".[dy]'] = {
                message = function(keys)
                    return "Use " .. keys:sub(4, 6) .. keys:sub(2, 3) .. " instead of " .. keys
                end,
                length = 6,
            },
        },
    },
}
