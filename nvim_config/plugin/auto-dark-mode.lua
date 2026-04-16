vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/f-person/auto-dark-mode.nvim",
})

require("auto-dark-mode").setup({
    update_interval = 3000,
    set_dark_mode = function()
        local custom_lualine_themes = require("radlinskii.utils.lualine_themes")

        vim.api.nvim_set_option_value("background", "dark", { scope = "global" })
        vim.cmd("colorscheme kanagawa-wave")

        if package.loaded["lualine"] then
            require("lualine").setup({ options = { theme = custom_lualine_themes.get_dark_theme() } })
        end
    end,
    set_light_mode = function()
        local custom_lualine_themes = require("radlinskii.utils.lualine_themes")

        vim.api.nvim_set_option_value("background", "light", { scope = "global" })
        vim.cmd("colorscheme kanagawa-lotus")

        if package.loaded["lualine"] then
            require("lualine").setup({ options = { theme = custom_lualine_themes.get_light_theme() } })
        end
    end,
})
