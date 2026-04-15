local autocmd = vim.api.nvim_create_autocmd

-- Don't list quickfix buffers
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- Autoresize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

-- Open help windows as vertical splits by default
autocmd("FileType", {
    pattern = "help",
    command = ":wincmd L | :vert resize 84",
})

-- Autosave buffers when leaving them
autocmd({ "BufLeave", "FocusLost" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd("silent! wall")
    end,
})

-- wrap, linebreak and spellcheck on markdown and text files
autocmd("FileType", {
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})

autocmd("LspAttach", { callback = require("radlinskii.utils.lsp").on_attach })
