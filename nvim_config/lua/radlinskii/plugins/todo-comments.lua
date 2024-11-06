---@type LazyPluginSpec
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "folke/trouble.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {
            "<leader>xT",
            "<cmd>TodoTrouble<CR>",
            desc = "Open Trouble with TODOs filter",
        },
        {
            "<leader>fT",
            "<cmd>TodoTelescope<CR>",
            desc = "Find TODOs",
        },
    },
    opts = {
        keywords = {
            TODO = { alt = { "todo" } },
        },
        highlight = {
            keyword = "bg",
        },
    },
}
