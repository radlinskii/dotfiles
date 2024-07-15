---@type LazyPluginSpec
return {
    "folke/noice.nvim",
    event = "VeryLazy",
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
        },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },

        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.60)
        end,
        on_open = function(win)
            vim.api.nvim_win_set_config(win, { focusable = false })
        end,
        render = "default",
        stages = "fade_in_slide_out",

        -- defualt messages to mini
        messages = { view = "mini", view_warn = "mini" },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    keys = {
        {
            "<leader>nn",
            function()
                require("noice").cmd("dismiss")
            end,
            desc = "Dismiss all notifications",
        },
        {
            "<leader>fn",
            function()
                require("noice").cmd("telescope")
            end,
            desc = "Find notification in history using Telescope",
        },
    },
}
