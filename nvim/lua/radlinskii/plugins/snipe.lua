---@type LazyPluginSpec
return {
    "leath-dub/snipe.nvim",
    -- TODO: watch https://github.com/leath-dub/snipe.nvim/pull/13
    keys = {
        {
            "<leader>rb",
            function()
                require("snipe").open_buffer_menu()
            end,
            desc = "List buffers in Snipe window",
        },
    },
    opts = {
        hints = {
            dictionary = "tsragpfwqdcxzhkmjo",
        },
        ui = {
            position = "cursor",
            -- position = "topright",
        },
        navigate = {
            next_page = "U",
            prev_page = "E",
        },
    },
}
