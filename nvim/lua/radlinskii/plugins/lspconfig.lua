return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")

        local on_attach = require("radlinskii.utils.lsp").on_attach
        local capabilities = require("radlinskii.utils.lsp").capabilities

        -- if you just want default config for the servers then put them in a table
        local servers = { "html", "cssls", "tsserver", "marksman", "jsonls" }

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,

            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                },
            },
        })

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
    end,
}
