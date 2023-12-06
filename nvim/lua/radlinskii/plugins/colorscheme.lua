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
                        Substitute = { fg = theme.ui.bg, bg = theme.ui.fg },
                        LazyNormal = { bg = theme.ui.bg, fg = theme.ui.fg },
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
