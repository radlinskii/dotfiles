return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua", -- optional
    },
    config = function()
        local neogit = require("neogit")

        neogit.setup({
            filewatcher = {
                interval = 1000,
                enabled = true,
            },
            auto_refresh = true,
            mappings = {
                status = {
                    ["t"] = "Unstage",
                    ["T"] = "UnstageStaged",
                    ["u"] = false,
                    ["U"] = false,
                },
            },
        })

        vim.keymap.set("n", "<leader>g", "<CMD>Neogit<CR>", { desc = "Open neogit", noremap = true, silent = true })
    end,
}
