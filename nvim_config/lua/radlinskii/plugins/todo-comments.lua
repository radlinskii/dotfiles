---@type LazyPluginSpec
return {
    "folke/todo-comments.nvim",
    dependencies = { "folke/trouble.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {
            "<leader>xT",
            "<cmd>TodoTrouble<CR>",
            desc = "Open Trouble with TODOs filter",
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
