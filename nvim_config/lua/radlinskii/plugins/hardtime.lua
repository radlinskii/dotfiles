---@type LazyPluginSpec
return {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        disable_mouse = false,
        restricted_keys = {
            ["h"] = {},
            ["j"] = {},
            ["k"] = {},
            ["l"] = {},
            ["<Up>"] = { "n", "x" },
            ["<Down>"] = { "n", "x" },
            ["<Left>"] = { "n", "x" },
            ["<Right>"] = { "n", "x" },
        },
        disabled_keys = {
            ["<Up>"] = {},
            ["<Down>"] = {},
            ["<Left>"] = {},
            ["<Right>"] = {},
        },
        disabled_filetypes = { "buffer_manager", "harpoon", "snipe-menu" },
    },
}
