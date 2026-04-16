vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/gbprod/yanky.nvim" })

       require("yanky").setup()

        vim.keymap.set({ "n", "x" }, "<leader>p", "<cmd>YankyRingHistory<cr>", { desc = "Open Yank History" })
        vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank text" })
        vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put yanked text after cursor" })
        vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put yanked text before cursor" })
        vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Put yanked text after selection" })
        vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Put yanked text before selection" })
    end,
})

