---@type LazyPluginSpec
return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "neovim/nvim-lspconfig",
            event = { "BufReadPre", "BufNewFile" },
            dependencies = {
                -- dependencies of radlinskii.utils.lsp module
                "hrsh7th/cmp-nvim-lsp",
                "folke/which-key.nvim",
            },
        },
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")

        local on_attach = require("radlinskii.utils.lsp").on_attach
        local capabilities = require("radlinskii.utils.lsp").capabilities

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "lua_ls",
                "marksman",
                "jsonls",
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

        mason_lspconfig.setup_handlers({
            function(server_name)
                if server_name == "ts_ls" then
                    lspconfig.ts_ls.setup({
                        on_attach = on_attach,
                        capabilities = capabilities,

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
                elseif server_name == "lua_ls" then
                    lspconfig.lua_ls.setup({
                        on_attach = on_attach,
                        capabilities = capabilities,

                        settings = {
                            Lua = {
                                hint = {
                                    enable = true,
                                },
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
                                    checkThirdParty = false, -- TODO: check what it does
                                },
                            },
                        },
                    })
                else
                    lspconfig[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                    })
                end
            end,
        })

        -- Change the Diagnostic symbols in the sign column (left gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        --used by conform and nvim-lint, none-ls doesn't need it
        local mason_tool_installer = require("mason-tool-installer")

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "eslint_d",
                "cspell",
                "markdownlint",
            },
        })
    end,
}
