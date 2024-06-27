return {
    "mbbill/undotree",
    keys = { { "<leader>u", "<cmd> UndotreeToggle <CR>", desc = "Toggle UndoTree" } },
    config = function()
        local is_windows = require("radlinskii.utils.system").is_windows()

        if vim.fn.has("persistent_undo") then
            local target_path = vim.fn.expand("~/.local/share/nvim/custom_undodir")

            if vim.fn.isdirectory(target_path) == false then
                os.execute("mkdir -p " .. target_path)
            end

            vim.opt.undodir = target_path
            vim.opt.undofile = true
        end

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
            vim.keymap.set("n", "u", "<plug>UndotreeNextState", opts)
            vim.keymap.set("n", "e", "<plug>UndotreePreviousState", opts)
            vim.keymap.set("n", "k", "<plug>UndotreeUndo", opts)
            vim.keymap.set("n", "J", "<Nop>", opts)
            vim.keymap.set("n", "K", "<Nop>", opts)
            vim.keymap.set("n", "U", "<Nop>", opts)
            vim.keymap.set("n", "C", "<Nop>", opts)
        end
    end,
}
