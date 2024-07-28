---@type LazyPluginSpec[]
return {
    {
        "leath-dub/snipe.nvim",
        keys = {
            {
                "<leader>rb",
                function()
                    require("snipe").create_buffer_menu_toggler()()
                end,
                desc = "List buffers in Snipe window",
            },
        },
        opts = {
            hints = {
                dictionary = "tsragpfwqdcxzhkmjo",
            },
            navigate = {
                next_page = "U",
                prev_page = "E",
            },
        },
    },
}
