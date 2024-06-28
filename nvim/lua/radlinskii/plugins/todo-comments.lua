return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        keywords = {
            TODO = { alt = { "todo" } },
        },
        highlight = {
            keyword = "bg",
        },
    },
    config = function()
        vim.keymap.set(
            { "n" },
            "<leader>fT",
            "<cmd>TodoTelescope<CR>",
            { desc = "Find TODOs", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>xt",
            "<cmd>TodoTrouble<CR>",
            { desc = "Open Trouble with TODOs filter", silent = true, noremap = true }
        )
    end,
}
