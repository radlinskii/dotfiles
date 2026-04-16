vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

        require("grug-far").setup({})

        vim.keymap.set("n", "<leader>rr", "<cmd>GrugFar<cr>", { desc = "Find and Replace" })
        vim.keymap.set("x", "<leader>rr", "<cmd>GrugFarWithin<cr>", { desc = "Find and replace within a selection" })
    end,
})
