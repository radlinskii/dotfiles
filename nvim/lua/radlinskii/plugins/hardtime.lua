return {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = { "BufReadPre" },
    opts = {
        disabled_keys = {
            ["<Up>"] = { "" },
            ["<Down>"] = { "" },
            ["<Left>"] = { "" },
            ["<Right>"] = { "" },
        },
    },
}
