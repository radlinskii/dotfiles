---@type LazyPluginSpec
return {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
        "mason-org/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local mason = require("mason")
        --used by to install linters and formatters, none-ls would not need it
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup()

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
