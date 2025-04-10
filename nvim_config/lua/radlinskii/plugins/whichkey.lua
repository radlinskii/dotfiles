---@type LazyPluginSpec
return {
    "folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 400
    end,
    event = { "VeryLazy" },
    keys = {
        {
            "<leader>b?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Local Buffer keymaps",
        },
        {
            "<c-w><space>",
            function()
                require("which-key").show({ keys = "<c-w>", loop = true })
            end,
            desc = "Window Hydra Mode (which-key)",
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

        wk.add({ "<leader>b", group = "Buffer" })
        wk.add({ "<leader>g", group = "Toggle LazyGit", icon = { cat = "filetype", name = "git" } })
        wk.add({ "<leader>h", group = "Harpoon", icon = { cat = "filetype", name = "harpoon" } })
        wk.add({ "<leader>S", group = "Sessions", icon = { icon = " ", hl = "MiniIconsGreen" } })
        wk.add({ "<leader>f", group = "FzfLua", icon = { icon = " ", hl = "MiniIconsBlue" } })
        wk.add({ "<leader>fg", group = "FzfLua Git", icon = { cat = "filetype", name = "git" } })
        wk.add({ "<leader>e", group = "NvimTree", icon = { cat = "extension", name = "dot" } })
        wk.add({ "<leader>r", group = "Refactoring", icon = { icon = "󱌢" } })
        wk.add({ "<leader>n", group = "Misc", icon = { icon = "", hl = "MiniIconsRed" } })
        wk.add({ "<leader>d", group = "Diffview", icon = { icon = "󰦓" } })
        wk.add({ "<leader>D", group = "Debugger" })
        wk.add({ "<leader>x", group = "Trouble", icon = { icon = "󰙅", hl = "MiniIconsRed" } })
    end,
}
