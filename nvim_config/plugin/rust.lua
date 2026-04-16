vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    once = true,
    callback = function()
        vim.pack.add({
            {
                src = "https://github.com/mrcjkb/rustaceanvim",
                -- To avoid being surprised by breaking changes,
                -- I recommend you set a version range
                version = vim.version.range("^9"),
            },
        })
    end,
})
