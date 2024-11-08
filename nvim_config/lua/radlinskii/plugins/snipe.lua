---@type LazyPluginSpec
return {
    "leath-dub/snipe.nvim",
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
            next_page = "<right>",
            prev_page = "<left>",
            cancel_snipe = "<C-c>",
            close_buffer = "<C-d>",
            open_vsplit = "<C-/>",
            open_split = "<C-x>",
            -- Change tag manually
            change_tag = "C",
        },
    },
}
