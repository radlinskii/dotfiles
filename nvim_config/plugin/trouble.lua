vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.pack.add({
            {
                src = "https://github.com/nvim-tree/nvim-web-devicons",
            },
            {
                src = "https://github.com/folke/trouble.nvim",
            },
        })

        vim.keymap.set("n", "<leader>xx", function()
            require("trouble").toggle("diagnostics")
        end, { desc = "Toggle trouble window" })

        vim.keymap.set("n", "<leader>xe", "<cmd>Trouble diagnostics toggle filter.severity = vim.diagnostic.severity.ERROR<cr>", { desc = "Toggle only errors" })

        vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf = 0<cr>", { desc = "Toggle current buffer diagnostics" })

        vim.keymap.set("n", "<leader>xq", function()
            require("trouble").toggle("quickfix")
        end, { desc = "Toggle quickfix list" })

        vim.keymap.set("n", "<leader>xl", function()
            require("trouble").toggle("loclist")
        end, { desc = "toggle loclist" })

        require("trouble").setup({
            focus = true,
        })
    end,
})
