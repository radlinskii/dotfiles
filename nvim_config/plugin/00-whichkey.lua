vim.pack.add({ "https://github.com/folke/which-key.nvim" })

vim.o.timeout = true
vim.o.timeoutlen = 400

local wk = require("which-key")

wk.setup({
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
})

wk.add({ "<leader>b", group = "Buffer" })
wk.add({ "<leader>g", group = "Toggle LazyGit", icon = { cat = "filetype", name = "git" } })
wk.add({ "<leader>o", group = "OpenCode" })
wk.add({ "<leader>m", group = "MarkdownPreview" })
wk.add({ "<leader>S", group = "Sessions", icon = { icon = " ", hl = "MiniIconsGreen" } })
wk.add({ "<leader>f", group = "FzfLua", icon = { icon = " ", hl = "MiniIconsBlue" } })
wk.add({ "<leader>fg", group = "FzfLua Git", icon = { cat = "filetype", name = "git" } })
wk.add({ "<leader>e", group = "NvimTree", icon = { cat = "extension", name = "dot" } })
wk.add({ "<leader>r", group = "Refactoring", icon = { icon = "󱌢" } })
wk.add({ "<leader>n", group = "Misc", icon = { icon = "", hl = "MiniIconsRed" } })
wk.add({ "<leader>d", group = "Diffview", icon = { icon = "󰦓" } })
wk.add({ "<leader>D", group = "Debugger" })
wk.add({ "<leader>x", group = "Trouble", icon = { icon = "󰙅", hl = "MiniIconsRed" } })

vim.keymap.set({ "n" }, "<leader>b?", function()
    require("which-key").show({ global = false })
end, { desc = "Local Buffer keymaps" })

vim.keymap.set({ "n" }, "<c-w><space>", function()
    require("which-key").show({ keys = "<c-w>", loop = true })
end, { desc = "Window Hydra Mode (which-key)" })
