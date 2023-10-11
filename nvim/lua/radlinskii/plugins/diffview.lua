return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggle", "DiffviewFileHistory" },
    init = function()
        vim.keymap.set(
            "n",
            "<leader>dc",
            "<cmd>DiffviewClose<CR>",
            { desc = "Close Diffview", noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>do",
            "<cmd>DiffviewOpen<CR>",
            { desc = "Open Diffview", noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>dh",
            "<cmd>DiffviewFileHistory %<CR>",
            { desc = "Open file history Diffview", noremap = true, silent = true }
        )
    end,
    opts = {
        hooks = {
            diff_view_opened = function()
                vim.cmd("ColorizerDetachFromBuffer")
            end,
            diff_view_closed = function()
                vim.cmd("ColorizerAttachToBuffer")
                vim.cmd("ColorizerReloadAllBuffers")
            end,
        },
    },
}
