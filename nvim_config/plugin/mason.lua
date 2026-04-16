vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
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
