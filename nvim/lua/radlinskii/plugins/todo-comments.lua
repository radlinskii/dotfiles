return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPre",
    opts = {
        keywords = {
            TODO = { alt = { "todo" } },
        },
        highlight = {
            keyword = "bg",
        },
    },
}
