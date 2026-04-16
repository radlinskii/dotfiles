vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/nvim-tree/nvim-web-devicons",
            "https://github.com/folke/trouble.nvim",
        })

        require("trouble").setup({
            focus = true,
        })

        vim.keymap.set("n", "<leader>xx", function()
            require("trouble").toggle("diagnostics")
        end, { desc = "Toggle trouble window" })

        vim.keymap.set(
            "n",
            "<leader>xe",
            "<cmd>Trouble diagnostics toggle filter.severity = vim.diagnostic.severity.ERROR<cr>",
            { desc = "Toggle only errors" }
        )

        vim.keymap.set(
            "n",
            "<leader>xd",
            "<cmd>Trouble diagnostics toggle filter.buf = 0<cr>",
            { desc = "Toggle current buffer diagnostics" }
        )

        vim.keymap.set("n", "<leader>xq", function()
            require("trouble").toggle("quickfix")
        end, { desc = "Toggle quickfix list" })

        vim.keymap.set("n", "<leader>xl", function()
            require("trouble").toggle("loclist")
        end, { desc = "toggle loclist" })
    end,
})
