---@type LazyPluginSpec
return {
    "folke/noice.nvim",
    event = { "VeryLazy" },
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                timeout = 2500,
                max_height = function()
                    return math.floor(vim.o.lines * 0.75)
                end,
                max_width = function()
                    return math.floor(vim.o.columns * 0.40)
                end,
                on_open = function(win)
                    vim.api.nvim_win_set_config(win, { focusable = false })
                end,
                render = "wrapped-compact",
                stages = "slide",
            },
        },
    },
    keys = {
        {
            "<leader>nn",
            function()
                require("noice").cmd("dismiss")
            end,
            desc = "Dismiss all notifications",
        },
    },
    opts = {
        routes = {
            {
                view = "notify",
                filter = { event = "msg_showmode" },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                view = "mini",
            },
            {
                filter = {
                    event = "notify",
                    find = "You pressed the",
                },
                view = "mini",
            },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        presets = {
            bottom_search = true,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
        },
    },
}
