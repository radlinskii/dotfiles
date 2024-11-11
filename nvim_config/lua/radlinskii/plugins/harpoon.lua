---@type LazyPluginSpec
return {
    "ThePrimeagen/harpoon",
    keys = {
        {
            "<leader>hm",
            function()
                require("harpoon.mark").add_file()
            end,
            desc = "Mark using harpoon",
        },

        {
            "<leader>ho",
            function()
                require("harpoon.ui").toggle_quick_menu()
                -- wait for the menu to open
                vim.defer_fn(function()
                    vim.fn.feedkeys("$")
                end, 50)
            end,
            desc = "Open Harpoon quick menu",
        },

        {
            "<leader>hi",
            function()
                require("harpoon.ui").nav_next()
            end,
            desc = "Navigate to next mark in harpoon",
        },

        {
            "<leader>hn",
            function()
                require("harpoon.ui").nav_prev()
            end,
            desc = "Navigate to prev mark in harpoon",
        },

        {
            "<leader>ht",
            function()
                require("harpoon.ui").nav_file(1)
            end,
            desc = "Navigate to 1st mark in harpoon",
        },

        {
            "<leader>hs",
            function()
                require("harpoon.ui").nav_file(2)
            end,
            desc = "Navigate to 2nd mark in harpoon",
        },

        {
            "<leader>hr",
            function()
                require("harpoon.ui").nav_file(3)
            end,
            desc = "Navigate to 3rd mark in harpoon",
        },

        {
            "<leader>hp",
            function()
                require("harpoon.ui").nav_file(4)
            end,
            desc = "Navigate to 4th mark in harpoon",
        },

        {
            "<leader>hf",
            function()
                require("harpoon.ui").nav_file(5)
            end,
            desc = "Navigate to 5th mark in harpoon",
        },

        {
            "<leader>hw",
            function()
                require("harpoon.ui").nav_file(6)
            end,
            desc = "Navigate to 6th mark in harpoon",
        },

        {
            "<leader>hd",
            function()
                require("harpoon.ui").nav_file(7)
            end,
            desc = "Navigate to 6th mark in harpoon",
        },

        {
            "<leader>hc",
            function()
                require("harpoon.ui").nav_file(8)
            end,
            desc = "Navigate to 6th mark in harpoon",
        },

        {
            "<leader>hx",
            function()
                require("harpoon.ui").nav_file(9)
            end,
            desc = "Navigate to 6th mark in harpoon",
        },
    },
    config = function()
        local opts = { noremap = true, silent = true }
        local autocmd = vim.api.nvim_create_autocmd

        autocmd("FileType", {
            desc = "Toggle buffer manager off",
            pattern = { "harpoon" },
            callback = function()
                vim.api.nvim_buf_set_keymap(
                    0,
                    "n",
                    "<C-c>",
                    "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
                    opts
                )
            end,
        })
    end,
}
