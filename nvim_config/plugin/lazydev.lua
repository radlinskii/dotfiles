vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/folke/lazydev.nvim" })

        require("lazydev").setup({
            library = {
                vim.env.VIMRUNTIME,
                { path = vim.fn.stdpath("config") .. "/lua", types = true },
                "lazy.nvim",
                "opencode",
            },
        })
    end,
})
