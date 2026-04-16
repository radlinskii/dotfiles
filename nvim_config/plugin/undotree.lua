vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/mbbill/undotree" })

        vim.keymap.set("n", "<leader>u", "<cmd> UndotreeToggle <CR>", { desc = "Toggle UndoTree" })

        local is_windows = require("radlinskii.utils.system").is_windows()

        if is_windows then
            vim.g.undotree_DiffCommand = "FC"
        end
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_DiffAutoOpen = 0
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_HelpLine = 0

        vim.g.Undotree_CustomMap = function()
            local opts = { buffer = 0, noremap = true, silent = true }

            vim.keymap.set("n", "q", "<Plug>UndotreeClose", opts)
            vim.keymap.set("n", "<up>", "<plug>UndotreeNextState", opts)
            vim.keymap.set("n", "<down>", "<plug>UndotreePreviousState", opts)
            vim.keymap.set("n", "u", "<plug>UndotreeUndo", opts)
        end
    end,
})
