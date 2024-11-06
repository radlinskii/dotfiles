---@type LazyPluginSpec
return {
    "f-person/auto-dark-mode.nvim",
    dependencies = { "nvim-lualine/lualine.nvim", "rebelot/kanagawa.nvim" },
    event = { "VeryLazy" },
    opts = {
        update_interval = 3000,
        set_dark_mode = function()
            local custom_lualine_themes = require("radlinskii.utils.lualine_themes")

            vim.api.nvim_set_option_value("background", "dark", { scope = "global" })
            vim.cmd("colorscheme kanagawa-wave")

            -- only change theme on lualine if it's loaded
            if package.loaded["lualine"] then
                require("lualine").setup({ options = { theme = custom_lualine_themes.get_dark_theme() } })
            end
        end,
        set_light_mode = function()
            local custom_lualine_themes = require("radlinskii.utils.lualine_themes")

            vim.api.nvim_set_option_value("background", "light", { scope = "global" })
            vim.cmd("colorscheme kanagawa-lotus")

            -- only change theme on lualine if it's loaded
            if package.loaded["lualine"] then
                require("lualine").setup({ options = { theme = custom_lualine_themes.get_light_theme() } })
            end
        end,
    },
}
