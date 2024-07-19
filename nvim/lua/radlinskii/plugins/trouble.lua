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
            "<leader>xe",
            "<cmd>Trouble diagnostics toggle filter.severity = vim.diagnostic.severity.ERROR<cr>",

            desc = "Toggle only errors",
        },
        {
            "<leader>xd",
            "<cmd>Trouble diagnostics toggle filter.buf = 0<cr>",
            desc = "Toggle current buffer diagnostics",
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
    opts = {
        focus = true,
    },
}
