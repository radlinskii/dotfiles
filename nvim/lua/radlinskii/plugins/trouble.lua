return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/which-key.nvim" },
    config = function(_, opts)
        local wk = require("which-key")
        wk.register({
            ["<leader>x"] = {
                name = "Trouble",
            },
        })

        -- Lua
        vim.keymap.set("n", "<leader>xx", function()
            require("trouble").toggle()
        end, {
            desc = "Toggle trouble window",
            noremap = true,
            silent = true,
        })
        vim.keymap.set("n", "<leader>xw", function()
            require("trouble").toggle("workspace_diagnostics")
        end, {
            desc = "Toggle workspace diagnostics",
            noremap = true,
            silent = true,
        })
        vim.keymap.set("n", "<leader>xd", function()
            require("trouble").toggle("document_diagnostics")
        end, {
            desc = "Toggle current buffer diagnostics",
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
        vim.keymap.set("n", "<leader>xr", function()
            require("trouble").toggle("lsp_references")
        end, {
            desc = "Toggle lsp references in Trouble",
            noremap = true,
            silent = true,
        })

        require("trouble").setup(opts)
    end,
}
