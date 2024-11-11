---@type LazyPluginSpec
return {
    "leath-dub/snipe.nvim",
    enabled = false,
    keys = {
        {
            "<leader>bs",
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
            position = "center",
        },
        navigate = {
            next_page = "<right>",
            prev_page = "<left>",
            cancel_snipe = "<C-c>",
            close_buffer = "<C-d>",
            open_vsplit = "<C-v>",
            open_split = "<C-h>",
            -- Change tag manually
            change_tag = "<C-e>",
        },
        sort = "default",
    },
}
