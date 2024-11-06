---@type LazyPluginSpec
return {
    "leath-dub/snipe.nvim",
    enabled = false,
    keys = {
        {
            "<leader><leader>",
            function()
                require("snipe").open_buffer_menu()
            end,
            desc = "List buffers in Snipe window",
        },
    },
    opts = {
        hints = {
            dictionary = "tsragpfwbdcxzvhkmjo",
        },
        ui = {
            position = "cursor",
        },
        navigate = {
            next_page = "U",
            prev_page = "E",
        },
    },
}
