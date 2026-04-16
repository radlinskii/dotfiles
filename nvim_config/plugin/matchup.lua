vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/andymass/vim-matchup" })



        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
})
