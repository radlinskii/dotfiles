return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/noice.nvim", "nvim-tree/nvim-web-devicons", "rebelot/kanagawa.nvim" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        lualine.setup({
            options = {
                theme = "auto",
            },
            sections = {
                lualine_x = {
                    {
                        require("noice").api.statusline.mode.get,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                },
                lualine_y = {
                    -- "progress"
                },
            },
        })
    end,
}
