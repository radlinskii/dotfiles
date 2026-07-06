local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

autocmd({ "BufLeave", "FocusLost" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd("silent! wall")
    end,
})

autocmd("LspAttach", { callback = require("radlinskii.utils.lsp").on_attach })

-- autocmd("UIEnter", {
--     callback = function()
--         require("radlinskii.utils.theme").set_auto_mode()
--     end,
-- })
