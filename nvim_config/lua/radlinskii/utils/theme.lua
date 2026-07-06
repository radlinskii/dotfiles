local M = {}

M.set_dark_mode = function()
    local custom_lualine_themes = require("radlinskii.utils.lualine_themes")

    vim.api.nvim_set_option_value("background", "dark", { scope = "global" })
    vim.cmd("colorscheme kanagawa-wave")

    if package.loaded["lualine"] then
        require("lualine").setup({ options = { theme = custom_lualine_themes.get_dark_theme() } })
    end
end

M.set_light_mode = function()
    local custom_lualine_themes = require("radlinskii.utils.lualine_themes")

    vim.api.nvim_set_option_value("background", "light", { scope = "global" })
    vim.cmd("colorscheme kanagawa-lotus")

    if package.loaded["lualine"] then
        require("lualine").setup({ options = { theme = custom_lualine_themes.get_light_theme() } })
    end
end

M.set_auto_mode = function()
    local hour = tonumber(os.date("%H"))
    if hour >= 8 and hour < 17 then
        M.set_light_mode()
    else
        M.set_dark_mode()
    end
end

return M
