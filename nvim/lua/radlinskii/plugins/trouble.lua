---@type LazyPluginSpec
return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>xx",
            function()
                require("trouble").toggle("diagnostics")
            end,
            desc = "Toggle trouble window",
        },
        {
            "<leader>xX",
            function()
                require("trouble").toggle({ mode = "diagnostics", focus = true })
            end,
            desc = "Toggle and focus trouble window",
        },
        {
            "<leader>xe",
            "<cmd>Trouble diagnostics toggle filter.severity = vim.diagnostic.severity.ERROR<cr>",

            desc = "Toggle only errors",
        },
        {
            "<leader>xE",
            "<cmd>Trouble diagnostics toggle focus = true filter.severity = vim.diagnostic.severity.ERROR<cr>",

            desc = "Toggle and focus only errors",
        },
        {
            "<leader>xd",
            "<cmd>Trouble diagnostics toggle filter.buf = 0<cr>",
            desc = "Toggle current buffer diagnostics",
        },
        {
            "<leader>xD",
            "<cmd>Trouble diagnostics toggle focus=true filter.buf = 0<cr>",
            desc = "Toggle and focus current buffer diagnostics",
        },
        {
            "<leader>xq",
            function()
                require("trouble").toggle("quickfix")
            end,
            desc = "Toggle quickfix list",
        },
        {
            "<leader>xl",
            function()
                require("trouble").toggle("loclist")
            end,
            desc = "toggle loclist",
        },
    },
}
