return {
    "andymass/vim-matchup",
    event = "BufReadPre",
    -- enabled = false,
    config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
}
