vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
    once = true,
    callback = function()
        vim.pack.add({
            { src = "https://github.com/nvim-lua/plenary.nvim" },
            { src = "https://github.com/sindrets/diffview.nvim" },
        })

        vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
        vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
        vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Open file history Diffview" })

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
    end,
})
