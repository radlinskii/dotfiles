---@type LazyPluginSpec
return {
    "MagicDuck/grug-far.nvim",
    keys = {
        {
            "<leader>sr",
            "<cmd>GrugFar<cr>",
            desc = "Find and Replace",
        },
        {
            "<leader>sr",
            "<cmd>GrugFarWithin<cr>",
            desc = "Find and replace within a selection",
            mode = { "x" },
        },
    },
    config = function()
        -- optional setup call to override plugin options
        -- alternatively you can set options with vim.g.grug_far = { ... }
        require("grug-far").setup({
            -- options, see Configuration section below
            -- there are no required options atm
            -- engine = 'ripgrep' is default, but 'astgrep' or 'astgrep-rules' can
            -- be specified
        })
    end,
}
