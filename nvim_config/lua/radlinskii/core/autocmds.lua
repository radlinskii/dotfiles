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

-- Highlighting when yanking text
autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
    end,
})

-- Prefer LSP folding if client supports it
autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client ~= nil and client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})
