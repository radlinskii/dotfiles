vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
    once = true,
    callback = function()
        vim.pack.add({
            { src = "https://github.com/folke/flash.nvim" },
        })

        require("flash").setup({
            search = {
                mode = "search",
                exclude = {
                    "blink-cmp-menu",
                    "blink-cmp-documentation",
                    "blink-cmp-signature",
                    "notify",
                    "cmp_menu",
                    "noice",
                    "flash_prompt",
                },
            },
            modes = {
                search = { enabled = false },
            },
        })

        vim.keymap.set({ "n", "x", "o" }, "s", function()
            require("flash").jump()
        end, { desc = "Flash" })

        vim.keymap.set({ "n", "x", "o" }, "S", function()
            require("flash").treesitter()
        end, { desc = "Flash Treesitter" })

        vim.keymap.set("o", "r", function()
            require("flash").remote()
        end, { desc = "Remote Flash" })

        vim.keymap.set({ "o", "x" }, "R", function()
            require("flash").treesitter_search()
        end, { desc = "Treesitter Search" })

        vim.keymap.set("c", "<c-s>", function()
            require("flash").toggle()
        end, { desc = "Toggle Flash Search" })
    end,
})
