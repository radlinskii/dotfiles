---@type LazyPluginSpec
return {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = { "hiphish/rainbow-delimiters.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
        local highlight = {
            "RainbowViolet",
            "RainbowRed",
            "RainbowBlue",
        }

        local function lightModeColorScheme()
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#79a4f5" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#a59Fc8" })
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#d47876" })
        end
        local function darkModeColorScheme()
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#4E699C" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#644F88" })
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#9A4056" })
        end

        local function getColorScheme()
            if vim.o.background == "dark" then
                return darkModeColorScheme
            else
                return lightModeColorScheme
            end
        end

        local hooks = require("ibl.hooks")
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, getColorScheme())

        vim.g.rainbow_delimiters = { highlight = highlight }
        require("ibl").setup({
            exclude = {
                filetypes = {
                    "help",
                    "terminal",
                    "lazy",
                    "lspinfo",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "mason",
                    "",
                },
                buftypes = { "terminal" },
            },
            scope = {
                highlight = highlight,
                show_start = true,
                show_end = true,
            },
        })

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
}
