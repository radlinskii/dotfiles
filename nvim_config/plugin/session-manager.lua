vim.pack.add({ "https://github.com/rmagatti/auto-session" })

require("auto-session").setup({
    auto_session_suppress_dirs = {
        "/",
        "~",
        "~/",
        "/tmp",
        "~/Downloads",
        "~/Documents",
        "~/Desktop",
        "~/Projects",
        "~/Library",
    },
    auto_save = true,
    auto_create = true,
    auto_restore = true,
})

vim.keymap.set("n", "<leader>SS", "<cmd>Autosession save<CR>", { desc = "Save current session" })
vim.keymap.set("n", "<leader>SD", "<cmd>Autosession deletePicker<CR>", { desc = "Delete sessions" })
vim.keymap.set("n", "<leader>SR", "<cmd>Autosession restore<CR>", { desc = "Restore current session" })
