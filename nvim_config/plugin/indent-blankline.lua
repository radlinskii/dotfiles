vim.pack.add({ "https://github.com/hiphish/rainbow-delimiters.nvim" ,
"https://github.com/lukas-reineke/indent-blankline.nvim" })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
    once = true,
    callback = function()
        local highlight = {
            "RainbowViolet",
            "RainbowRed",
            "RainbowBlue",
        }

        local function lightModeColorScheme()
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#6994f5" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#a55Fb8" })
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#e46876" })
        end
        local function darkModeColorScheme()
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#4E699C" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#844Fa8" })
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#AA4056" })
        end

        local function getColorScheme()
            if vim.o.background == "dark" then
                return darkModeColorScheme
            else
                return lightModeColorScheme
            end
        end

        local hooks = require("ibl.hooks")
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
})
