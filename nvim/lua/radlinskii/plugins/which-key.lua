return {
    "folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function(_, opts)
        local wk = require("which-key")

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

        wk.setup(opts)
    end,
}
