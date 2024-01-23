return {
    "m4xshen/hardtime.nvim",
    enabled = false,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = { "BufReadPre" },
    opts = {
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
