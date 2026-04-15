---@type LazyPluginSpec
return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "neovim/nvim-lspconfig",
            event = { "BufReadPre", "BufNewFile" },
            dependencies = {
                "folke/which-key.nvim",
                "saghen/blink.cmp",
                "ibhagwan/fzf-lua",
            },
        },
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local mason = require("mason")
        local lspconfig = require("lspconfig")
        --used by to install linters and formatters, none-ls would not need it
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup()

        local on_attach = require("radlinskii.utils.lsp").on_attach
        local custom_capabilities = require("radlinskii.utils.lsp").capabilities
        local blink_capabilities = require("blink.cmp").get_lsp_capabilities() -- TODO: test if custom_capabilities are obsolete

        vim.lsp.config("*", {
            capabilities = blink_capabilities,
            on_attach = on_attach,
            root_markers = { ".git" },
        })

        vim.lsp.config("ts_ls", {
            capabilities = blink_capabilities,
            on_attach = on_attach,
            settings = {
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
            },
        })

        vim.lsp.config("lua_ls", {
            capabilities = blink_capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    hint = {
                        enable = true,
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                },
            },
        })

        vim.lsp.config("gopls", {
            capabilities = blink_capabilities,
            on_attach = on_attach,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    },
                },
            },
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "lua_ls",
                "marksman",
                "jsonls",
                "gopls",
                "taplo",
                "astro",
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                -- { "eslint_d", version = "v13.1.2" }, -- TODO: bundles eslint@9 which doesn't work with eslintrc.js, but with eslint.config.js files
                -- just run: npm i -g eslint_d@13.1.2
                "cspell",
                "markdownlint",
                "gofumpt",
                "goimports",
                "golines",
                "gomodifytags",
                "gotests",
                "golangci-lint",
                "djlint",
                "stylelint",
            },
        })
    end,
}
