---@type LazyPluginSpec
return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            vim.env.VIMRUNTIME,
            { path = vim.fn.stdpath("config") .. "/lua", types = true },
            "lazy.nvim",
            "opencode",
        },
    },
}
