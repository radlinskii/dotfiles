---@type LazyPluginSpec[]
return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- Default options:
            require("kanagawa").setup({
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                dimInactive = true, -- dim inactive window `:h hl-NormalNC`
                colors = {
                    palette = {
                        samuraiRed = "#c83434",
                        peachRead = "#cf3D62",
                        oniViolet = "#957Fc8",
                        -- use dragon theme background colors for wave theme
                        sumiInk0 = "#0d0c0c", -- dragonBlack0
                        sumiInk1 = "#12120f", -- dragonBlack1
                        sumiInk2 = "#1D1C19", -- dragonBlack2
                        sumiInk3 = "#181616", -- dragonBlack3
                        sumiInk4 = "#282727", -- dragonBlack4
                        sumiInk5 = "#393836", -- dragonBlack5
                        sumiInk6 = "#625e5a", -- dragonBlack6
                        -- make light theme less solarized
                        lotusWhite0 = "#e2d8b1",
                        lotusWhite1 = "#ebe6bc",
                        lotusWhite2 = "#ecedd5",
                        lotusWhite3 = "#f0f2d6",
                        lotusWhite4 = "#e8edcf",
                        lotusWhite5 = "#e7e8c9",
                    },
                    theme = {
                        wave = {
                            ui = {
                                bg_dim = "#0d0c0c", -- dragonBlack0,
                            },
                        },
                        lotus = {
                            ui = {
                                bg_dim = "#e7e8c9", -- lotusWhite5
                            },
                        },
                        dragon = {},
                        all = {},
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme

                    return {
                        IblIndent = { fg = theme.ui.bg_gutter },
                        MatchParen = { ctermbg = "green", bg = theme.diff.add, italic = true, underline = true },
                        Substitute = { bg = theme.ui.fg, fg = theme.ui.bg },
                        LazyNormal = { bg = theme.ui.bg, fg = theme.ui.fg },
                        NormalFloat = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
                        FloatBorder = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
                        WhichKeyBorder = { bg = theme.ui.bg_p2, fg = theme.ui.fg },
                        WhichKeyFloat = { bg = theme.ui.bg_p2, fg = theme.ui.fg },
                        FlashLabel = { bg = "#ad33ad", fg = "#22dd22" },
                        -- TabLineFill - Tab pages line, where there are no labels.
                        TabLineFill = { bg = theme.ui.bg_p1 },
                        -- TabLine - Tab pages line, not active tab page label.
                        TabLine = { bg = theme.ui.bg_p2, fg = theme.ui.fg_dim },
                        -- TabLineSel - Tab pages line, active tab page label.
                        TabLineSel = { bg = theme.ui.bg_m1, fg = theme.diag.warning },
                        LspReferenceWrite = { bg = theme.ui.bg_p2 },
                        LspReferenceRead = { bg = theme.ui.bg_p2 },
                        LspReferenceTarget = { bg = theme.ui.bg_p2 },
                        LspReferenceText = { bg = theme.ui.bg_p2 },
                    }
                end,
                theme = "wave", -- Load "wave" theme when 'background' option is not set
                background = { -- map the value of 'background' option to a theme
                    dark = "wave",
                    light = "lotus",
                },
            })

            -- setup must be called before loading
            vim.cmd("colorscheme kanagawa")
        end,
    },
}
