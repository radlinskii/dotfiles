---@type LazyPluginSpec
return {
    "folke/flash.nvim",
    enabled = true,
    opts = {
        search = {
            incremental = true,
            mode = "search",
            exclude = {
                "blink-cmp-menu",
                "blink-cmp-documentation",
                "blink-cmp-signature",
            },
        },
        modes = {
            search = { enabled = true },
            char = {
                -- TODO: broken after 0.11 update
                enabled = false,
            },
        },
    },
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
        {
            "R",
            mode = { "o", "x" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "Treesitter Search",
        },
        {
            "<c-s>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash Search",
        },
    },
}
