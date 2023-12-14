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
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function(_, opts)
        require("noice").setup(opts)

        vim.keymap.set("n", "<leader>nn", function()
            require("noice").cmd("dismiss")
        end, {
            desc = "Dismiss all notifications",
            noremap = true,
            silent = true,
        })
        vim.keymap.set("n", "<leader>fn", function()
            require("noice").cmd("telescope")
        end, {
            desc = "Find notification in history using Telescope",
            noremap = true,
            silent = true,
        })
    end,
}
