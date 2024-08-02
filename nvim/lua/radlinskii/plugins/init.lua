---@type LazyPluginSpec[]
return {
    { "tpope/vim-sleuth", lazy = false },
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        dependencies = { { "Bilal2453/luvit-meta" } },
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "leath-dub/snipe.nvim",
        -- TODO: watch https://github.com/leath-dub/snipe.nvim/pull/13
        keys = {
            {
                "<leader>rb",
                function()
                    require("snipe").open_buffer_menu()
                end,
                desc = "List buffers in Snipe window",
            },
        },
        opts = {
            hints = {
                dictionary = "tsragpfwqdcxzhkmjo",
            },
            ui = {
                position = "cursor",
                -- position = "topright",
            },
            navigate = {
                next_page = "U",
                prev_page = "E",
            },
        },
    },
    {
        "OXY2DEV/markview.nvim",
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local markview = require("markview")
            local def_hls = markview.configuration.highlight_groups

            require("markview").setup({
                highlight_groups = vim.list_extend(def_hls, {
                    {
                        group_name = "rev_purple",
                        value = { bg = "#c4a7e7", fg = "#191724" },
                    },
                    {
                        group_name = "rev_cyan",
                        value = { bg = "#9ccfd8", fg = "#191724" },
                    },
                    {
                        group_name = "rev_pink",
                        value = { bg = "#ebbcba", fg = "#191724" },
                    },
                    {
                        group_name = "rev_yellow",
                        value = { bg = "#f6c177", fg = "#191724" },
                    },
                    {
                        group_name = "rev_green",
                        value = { bg = "#51a48f", fg = "#191724" },
                    },
                    {
                        group_name = "rev_cyan",
                        value = { bg = "#9ccfd8", fg = "#191724" },
                    },
                    {
                        group_name = "rev_gray",
                        value = { bg = "#908caa", fg = "#26233a" },
                    },
                }),
                headings = {
                    enable = true,
                    -- FIX: signs not on a single line
                    shift_width = 0,
                    heading_1 = {
                        style = "label",
                        icon = "󰼏  ",
                        sign = "󰓹 ",
                        hl = "rev_cyan",
                        padding_left = " ",
                        corner_left = " ─ ✦",
                        corner_left_hl = "rev_cyan",
                        padding_right = " ",
                        corner_right = "✦ ─ ",
                        corner_right_hl = "rev_cyan",
                    },
                    heading_2 = {
                        style = "label",
                        icon = "󰎨  ",
                        sign = "󰓼 ",
                        hl = "rev_green",
                        padding_left = " ",
                        corner_left = " ── ✦✦",
                        corner_left_hl = "rev_green",
                        padding_right = " ",
                        corner_right = "✦✦ ── ",
                        corner_right_hl = "rev_green",
                    },
                    heading_3 = {
                        style = "label",
                        icon = "󰼑  ",
                        sign = "󰓹",
                        hl = "rev_purple",
                        padding_left = " ",
                        corner_left = " ─── ✦✦✦",
                        corner_left_hl = "rev_purple",
                        padding_right = " ",
                        corner_right = "✦✦✦ ─── ",
                        corner_right_hl = "rev_purple",
                    },
                    heading_4 = {
                        style = "label",
                        icon = "󰎲  ",
                        sign = "󰓼 ",
                        hl = "rev_gray",
                        padding_left = " ",
                        corner_left = " ──── ✦✦✦✦",
                        corner_left_hl = "rev_gray",
                        padding_right = " ",
                        corner_right = "✦✦✦✦ ──── ",
                        corner_right_hl = "rev_gray",
                    },
                    heading_5 = {
                        style = "label",
                        icon = "󰼓  ",
                        sign = "󰓼 ",
                        hl = "rev_pink",
                        padding_left = " ",
                        corner_left = " ───── ✦✦✦✦✦",
                        corner_left_hl = "rev_pink",
                        padding_right = " ",
                        corner_right = "✦✦✦✦✦ ───── ",
                        corner_right_hl = "rev_pink",
                    },
                    heading_6 = {
                        style = "label",
                        icon = "󰎴  ",
                        sign = "󰓼 ",
                        hl = "rev_yellow",
                        padding_left = " ",
                        corner_left = " ───── ✦✦✦✦✦✦",
                        corner_left_hl = "rev_yellow",
                        padding_right = " ",
                        corner_right = "✦✦✦✦✦✦ ───── ",
                        corner_right_hl = "rev_yellow",
                    },
                },
            })

            vim.keymap.set(
                "n",
                "<leader>nm",
                "<cmd>Markview<cr>",
                { desc = "Toggle markview", noremap = true, silent = true }
            )
        end,
    },
}
