return {
    "folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 400
    end,
    lazy = false,
    priority = 900,
    opts = {

        window = {
            border = "single", -- none, single, double, shadow
            margin = { 1, 3, 1, 2 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
        },
    },
    config = function(_, opts)
        local wk = require("which-key")

        wk.setup(opts)

        wk.register({
            ["<leader>r"] = {
                name = "Refactoring",
            },
        })
        wk.register({
            ["<leader>n"] = {
                name = "No!",
            },
        })
    end,
}
