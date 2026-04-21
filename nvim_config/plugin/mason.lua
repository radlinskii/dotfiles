vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

local mason_lspconfig = require("mason-lspconfig")
local mason = require("mason")
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
        "prettier",
        "eslint_d",
        "stylua",
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
