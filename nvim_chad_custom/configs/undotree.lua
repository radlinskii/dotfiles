if vim.fn.has("persistent_undo") == 1 then
    local target_path = vim.fn.expand("~/.config/nvim/.undo")

    if vim.fn.isdirectory(target_path) == false then
        os.execute("mkdir -p " .. target_path)
    end

    vim.opt.undodir = target_path
    vim.opt.undofile = true
end

vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_DiffAutoOpen = 0
vim.g.undotree_WindowLayout = 2
vim.g.undotree_HelpLine = 0

vim.g.Undotree_CustomMap = function()
    local b = { buffer = 0 }

    vim.keymap.set("n", "q", "<Plug>UndotreeClose", b)
    vim.keymap.set("n", "u", "<plug>UndotreeNextState", b)
    vim.keymap.set("n", "e", "<plug>UndotreePreviousState", b)
    vim.keymap.set("n", "k", "<plug>UndotreeUndo", b)
    vim.keymap.set("n", "J", "<Nop>", b)
    vim.keymap.set("n", "K", "<Nop>", b)
    vim.keymap.set("n", "U", "<Nop>", b)
    vim.keymap.set("n", "C", "<Nop>", b)
end
