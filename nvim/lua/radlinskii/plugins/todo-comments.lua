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
}
