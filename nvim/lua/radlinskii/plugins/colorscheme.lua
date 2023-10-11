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
                        sumiInk0 = "#0d0c0c",
                        sumiInk1 = "#12120f",
                        sumiInk2 = "#1D1C19",
                        sumiInk3 = "#181616",
                        sumiInk4 = "#282727",
                        sumiInk5 = "#393836",
                        sumiInk6 = "#625e5a",
                        -- make light theme less solarized
                        lotusWhite0 = "#e2d8b1",
                        lotusWhite1 = "#ebe6bc",
                        lotusWhite2 = "#ecedd5",
                        lotusWhite3 = "#f0f2d6",
                        lotusWhite4 = "#e8edcf",
                        lotusWhite5 = "#e7e8c9",
                    },
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors)
                    local theme = colors.theme

                    return {
                        IblIndent = { fg = theme.ui.bg_gutter },
                    }
                end,
                theme = "wave", -- Load "wave" theme when 'background' option is not set
                background = { -- map the value of 'background' option to a theme
                    dark = "wave", -- try "dragon" !
                    light = "lotus",
                },
            })

            -- setup must be called before loading
            vim.cmd("colorscheme kanagawa")
        end,
    },
}
