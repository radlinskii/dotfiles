---@type LazyPluginSpec
return {
    "nvimtools/hydra.nvim",
    event = "VeryLazy",
    config = function()
        local Hydra = require("hydra")

        Hydra({
            name = "Resize Splits",
            mode = "n",
            body = "<c-w>",
            heads = {
                { "<c-n>", ":vertical resize -2<CR>", { silent = true } },
                { "<c-e>", ":resize -2<CR>", { silent = true } },
                { "<c-u>", ":resize +2<CR>", { silent = true } },
                { "<c-i>", ":vertical resize +2<CR>", { silent = true } },
            },
        })

        Hydra({
            name = "Horizontal Scroll",
            mode = "n",
            body = "z",
            heads = {
                { "i", "3zl", { silent = true } },
                { "n", "3zh", { silent = true } },
                { "I", "zL", { silent = true } },
                { "N", "zH", { silent = true } },
            },
        })
    end,
}
