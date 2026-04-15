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

        ---@type string | table
        local theme = "auto"

        if vim.o.background == "light" then
            theme = custom_lualine_themes.get_light_theme()
        elseif vim.o.background == "dark" then
            theme = custom_lualine_themes.get_dark_theme()
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
                        require("noice").api.status.mode.get,
                        cond = require("noice").api.status.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        require("noice").api.status.search.get,
                        cond = require("noice").api.status.search.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        "lsp_status",
                    },
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
                lualine_z = {
                    {
                        "location",
                        fmt = function(str)
                            return str .. "/" .. vim.fn.line("$")
                        end,
                    },
                },
            },
        })
    end,
}
