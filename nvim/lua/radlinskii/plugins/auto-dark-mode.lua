---@type LazyPluginSpec
return {
    "f-person/auto-dark-mode.nvim",
    event = { "VeryLazy" },
    opts = {
        update_interval = 3000,
        set_dark_mode = function()
            vim.api.nvim_set_option_value("background", "dark", { scope = "global" })
            vim.cmd("colorscheme kanagawa-wave")
        end,
        set_light_mode = function()
            vim.api.nvim_set_option_value("background", "light", { scope = "global" })
            vim.cmd("colorscheme kanagawa-lotus")
        end,
    },
}
