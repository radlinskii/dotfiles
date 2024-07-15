---@type LazyPluginSpec
return {
    "folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 400
    end,
    lazy = false,
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Loacal Buffer keymaps",
        },
    },
    priority = 900,
    opts = {
        win = {
            border = "single", -- none, single, double, shadow
        },
    },
    config = function(_, opts)
        local wk = require("which-key")

        wk.setup(opts)

        wk.add({ "<leader>h", group = "Harpoon" })
        wk.add({ "<leader>s", group = "CtrlSF" })
        wk.add({ "<leader>f", group = "Telescope" })
        wk.add({ "<leader>fg", group = "Telescope Git" })
        wk.add({ "<leader>e", group = "NvimTree" })
        wk.add({ "<leader>r", group = "Refactoring" })
        wk.add({ "<leader>n", group = "Misc" })
        wk.add({ "<leader>d", group = "Diffview/Debugger" })
        wk.add({ "<leader>df", group = "Diffview" })
        wk.add({ "<leader>db", group = "Debugger" })
        wk.add({ "<leader>x", group = "Trouble" })
    end,
}
