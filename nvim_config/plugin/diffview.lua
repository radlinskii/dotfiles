vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/sindrets/diffview.nvim",
        })

        require("diffview").setup({
            hooks = {
                diff_view_opened = function()
                    vim.cmd("ColorizerDetachFromBuffer")
                end,
                diff_view_closed = function()
                    vim.cmd("ColorizerAttachToBuffer")
                    vim.cmd("ColorizerReloadAllBuffers")
                end,
            },
        })

        vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
        vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
        vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Open file history Diffview" })
    end,
})
