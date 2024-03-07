return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

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
                "tsserver",
                "html",
                "cssls",
                "lua_ls",
                "marksman",
                -- "jsonls",
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

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
