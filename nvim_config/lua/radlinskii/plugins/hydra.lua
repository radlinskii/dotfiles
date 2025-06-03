---@type LazyPluginSpec
return {
    "nvimtools/hydra.nvim",
    event = { "VeryLazy" },
    enabled = false,
    config = function()
        local Hydra = require("hydra")

        Hydra({
            name = "Resize Splits",
            mode = "n",
            body = "<c-w>",
            heads = {
                { ">", ":vertical resize -2<CR>", { silent = true } },
                { "<", ":vertical resize +2<CR>", { silent = true } },
                { "-", ":resize -2<CR>", { silent = true } },
                { "+", ":resize +2<CR>", { silent = true } },
            },
        })

        Hydra({
            name = "Horizontal Scroll",
            mode = "n",
            body = "z",
            heads = {
                { "<right>", "3z<right>", { silent = true } },
                { "<left>", "3z<left>", { silent = true } },
                { "l", "3zl", { silent = true } },
                { "h", "3zh", { silent = true } },
                { "L", "zL", { silent = true } },
                { "H", "zH", { silent = true } },
            },
        })
    end,
}
