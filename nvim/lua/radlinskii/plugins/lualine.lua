---@type LazyPluginSpec
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "folke/noice.nvim",
        "nvim-tree/nvim-web-devicons",
        "rebelot/kanagawa.nvim",
    },
    event = { "VimEnter" },
    config = function()
        local lualine = require("lualine")
        local custom_lualine_themes = require("radlinskii.utils.lualine_themes")
        -- local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        ---@type string | table
        local theme = "auto"

        if vim.o.background == "light" then
            theme = custom_lualine_themes.get_light_theme()
        elseif vim.o.background == "dark" then
            theme = custom_lualine_themes.get_light_theme()
        end

        lualine.setup({
            options = {
                theme,
            },
            sections = {
                lualine_c = {
                    { "filename", path = 1 },
                },
                lualine_x = {
                    {
                        require("noice").api.statusline.mode.get,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    -- {
                    --     lazy_status.updates,
                    --     cond = lazy_status.has_updates,
                    -- },
                    -- { "encoding" },
                    {
                        "fileformat",
                        symbols = {
                            unix = " ", -- e712 + space
                            dos = " ", -- e70f + space
                            mac = " ", -- e711 + space
                        },
                    },
                },
                lualine_y = {
                    -- "progress",
                    "filetype",
                },
            },
        })
    end,
}
