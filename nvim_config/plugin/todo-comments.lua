vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })

        require("todo-comments").setup({
            keywords = {
                TODO = { alt = { "todo" } },
            },
            highlight = {
                keyword = "bg",
                pattern = [[.*<(KEYWORDS)\s*]],
            },
        })
    end,
})
