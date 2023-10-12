return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "rmagatti/auto-session", "rebelot/kanagawa.nvim" },
    event = { "VimEnter" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count
        local current_session_name = require("auto-session.lib").current_session_name

        lualine.setup({
            options = {
                theme = require("lualine.themes.kanagawa"),
            },
            sections = {
                lualine_b = { current_session_name, "branch", "diff", "diagnostics" },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                },
            },
        })
    end,
}
