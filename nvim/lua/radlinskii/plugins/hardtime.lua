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
        disabled_filetypes = { "fugitive" },
    },
}
