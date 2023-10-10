local autocmd = vim.api.nvim_create_autocmd

-- don't list quickfix buffers
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

-- open help windows as vertical splits by default
autocmd("FileType", {
    pattern = "help",
    command = ":wincmd L | :vert resize 84",
})
