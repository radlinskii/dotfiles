return {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = { "folke/which-key.nvim" },
    config = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>h"] = {
                name = "Harpoon",
            },
        })

        -- Harpoon mappings for Normal mode
        vim.keymap.set("n", "<leader>hm", function()
            require("harpoon.mark").add_file()
        end, { desc = "Mark using harpoon", silent = true, noremap = true })

        vim.keymap.set("n", "<leader>ho", function()
            require("harpoon.ui").toggle_quick_menu()
        end, { desc = "Open Harpoon quick menu", silent = true, noremap = true })

        vim.keymap.set("n", "<leader>hi", function()
            require("harpoon.ui").nav_next()
        end, { desc = "Navigate to next mark in harpoon", silent = true, noremap = true })

        vim.keymap.set("n", "<leader>hn", function()
            require("harpoon.ui").nav_prev()
        end, { desc = "Navigate to prev mark in harpoon", silent = true, noremap = true })

        vim.keymap.set("n", "<leader>ht", function()
            require("harpoon.ui").nav_file(1)
        end, { desc = "Navigate to 1st mark in harpoon", silent = true, noremap = true })

        vim.keymap.set("n", "<leader>hs", function()
            require("harpoon.ui").nav_file(2)
        end, { desc = "Navigate to 2nd mark in harpoon", silent = true, noremap = true })

        vim.keymap.set("n", "<leader>hr", function()
            require("harpoon.ui").nav_file(3)
        end, { desc = "Navigate to 3rd mark in harpoon", silent = true, noremap = true })

        vim.keymap.set("n", "<leader>hp", function()
            require("harpoon.ui").nav_file(4)
        end, { desc = "Navigate to 4th mark in harpoon", silent = true, noremap = true })

        vim.keymap.set("n", "<leader>hf", function()
            require("harpoon.ui").nav_file(5)
        end, { desc = "Navigate to 5th mark in harpoon", silent = true, noremap = true })

        vim.keymap.set("n", "<leader>hw", function()
            require("harpoon.ui").nav_file(6)
        end, { desc = "Navigate to 6th mark in harpoon", silent = true, noremap = true })
    end,
}
