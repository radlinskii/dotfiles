---@type LazyPluginSpec[]
return {
    {
        "leath-dub/snipe.nvim",
        keys = {
            {
                "<leader>rb",
                function()
                    require("snipe").create_buffer_menu_toggler()()
                end,
                desc = "List buffers in Snipe window",
            },
        },
        opts = {
            hints = {
                dictionary = "tsragpfwqdcxzhkmjo",
            },
            navigate = {
                next_page = "U",
                prev_page = "E",
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
                            -- sign = "󰓹 ",
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
                            icon = "󰎨 ",
                            -- sign = "󰓼 ",
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
                            icon = "󰼑 ",
                            -- sign = "󰓹",
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
                            icon = "󰎲 ",
                            -- sign = "󰓼 ",
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
                            icon = "󰼓 ",
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
                            icon = "󰎴 ",
                            -- sign = "󰓼 ",
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
            end,
        },
    },
}
