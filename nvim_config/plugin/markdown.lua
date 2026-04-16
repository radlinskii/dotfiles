vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/selimacerbas/live-server.nvim",
            { src = "https://github.com/selimacerbas/markdown-preview.nvim", name = "markdown_preview" },
        })

        require("markdown_preview").setup({
            instance_mode = "takeover",
            port = 0,
            open_browser = true,
            debounce_ms = 300,
        })

        vim.keymap.set("n", "<leader>mps", "<cmd>MarkdownPreview<cr>", { desc = "Markdown: Start preview" })
        vim.keymap.set("n", "<leader>mpS", "<cmd>MarkdownPreviewStop<cr>", { desc = "Markdown: Stop preview" })
        vim.keymap.set("n", "<leader>mpr", "<cmd>MarkdownPreviewRefresh<cr>", { desc = "Markdown: Refresh preview" })
    end,
})
