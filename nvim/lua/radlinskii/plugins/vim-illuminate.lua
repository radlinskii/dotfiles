return {
    "RRethy/vim-illuminate",
    event = "BufReadPre",
    config = function()
        -- vim.cmd("hi IlluminatedWordText guibg=#5e4a3a gui=none")
        -- vim.cmd("hi IlluminatedWordRead guibg=#5e4a3a gui=none")
        -- vim.cmd("hi IlluminatedWordWrite guibg=#5e4a3a gui=none")

        require("illuminate").configure({
            providers = {
                -- "lsp",
                -- "treesitter",
                "regex",
            },
        })
    end,
}
