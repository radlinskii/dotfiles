return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggle", "DiffviewFileHistory" },
    keys = { { "<leader>df", desc = "DiffView" } },
    dependencies = { "folke/which-key.nvim" },
    init = function()
        local wk = require("which-key")

        wk.register({
            ["<leader>d"] = {
                name = "Diffview/Debugger",
            },
        })
        wk.register({
            ["<leader>df"] = {
                name = "Diffview",
            },
        })

        vim.keymap.set(
            "n",
            "<leader>dfc",
            "<cmd>DiffviewClose<CR>",
            { desc = "Close Diffview", noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>dfo",
            "<cmd>DiffviewOpen<CR>",
            { desc = "Open Diffview", noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>dfh",
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
