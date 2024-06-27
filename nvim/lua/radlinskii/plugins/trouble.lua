return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/which-key.nvim" },
    keys = { { "<leader>x", desc = "Trouble" } },
    config = function(_, opts)
        vim.keymap.set("n", "<leader>xx", function()
            require("trouble").toggle("diagnostics")
        end, {
            desc = "Toggle trouble window",
            noremap = true,
            silent = true,
        })
        vim.keymap.set("n", "<leader>xX", function()
            require("trouble").toggle({ mode = "diagnostics", focus = true })
        end, {
            desc = "Toggle and focus trouble window",
            noremap = true,
            silent = true,
        })
        vim.keymap.set(
            "n",
            "<leader>xe",
            "<cmd>Trouble diagnostics toggle filter.severity = vim.diagnostic.severity.ERROR<cr>",
            {
                desc = "Toggle only errors",
                noremap = true,
                silent = true,
            }
        )
        vim.keymap.set(
            "n",
            "<leader>xE",
            "<cmd>Trouble diagnostics toggle focus = true filter.severity = vim.diagnostic.severity.ERROR<cr>",
            {
                desc = "Toggle and focus only errors",
                noremap = true,
                silent = true,
            }
        )
        vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf = 0<cr>", {
            desc = "Toggle current buffer diagnostics",
            noremap = true,
            silent = true,
        })
        vim.keymap.set("n", "<leader>xD", "<cmd>Trouble diagnostics toggle focus=true filter.buf = 0<cr>", {
            desc = "Toggle and focus current buffer diagnostics",
            noremap = true,
            silent = true,
        })
        vim.keymap.set("n", "<leader>xq", function()
            require("trouble").toggle("quickfix")
        end, {
            desc = "Toggle quickfix list",
            noremap = true,
            silent = true,
        })
        vim.keymap.set("n", "<leader>xl", function()
            require("trouble").toggle("loclist")
        end, {
            desc = "toggle loclist",
            noremap = true,
            silent = true,
        })

        require("trouble").setup(opts)
    end,
}
