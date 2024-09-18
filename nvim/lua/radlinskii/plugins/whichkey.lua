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
            desc = "Local Buffer keymaps",
        },
    },
    priority = 900,
    opts = {
        preset = "modern",
        delay = 400,
        win = {
            width = 0.8,
        },
        icons = {
            keys = {
                BS = "⌫ ",
            },
        },
    },
    config = function(_, opts)
        local wk = require("which-key")

        wk.setup(opts)

        wk.add({ "<leader>h", group = "Harpoon", icon = { cat = "filetype", name = "harpoon" } })
        wk.add({ "<leader>s", group = "CtrlSF/Sessions", icon = { icon = " ", hl = "MiniIconsGreen" } })
        wk.add({ "<leader>f", group = "Telescope" })
        wk.add({ "<leader>fg", group = "Telescope Git", icon = { cat = "filetype", name = "git" } })
        wk.add({ "<leader>e", group = "NvimTree", icon = { cat = "filetype", name = "nvimtree" } })
        wk.add({ "<leader>r", group = "Refactoring", icon = { icon = "󱌢" } })
        wk.add({ "<leader>n", group = "Misc", icon = { icon = "", hl = "MiniIconsRed" } })
        wk.add({ "<leader>d", group = "Diffview/Debugger", icon = { icon = "󰦓" } })
        wk.add({ "<leader>df", group = "Diffview", icon = { icon = "󰦓" } })
        wk.add({ "<leader>db", group = "Debugger" })
        wk.add({ "<leader>x", group = "Trouble", icon = { icon = "󰙅", hl = "MiniIconsRed" } })
    end,
}
