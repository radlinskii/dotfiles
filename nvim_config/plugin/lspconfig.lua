vim.pack.add({
    "https://github.com/folke/which-key.nvim",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/neovim/nvim-lspconfig",
})

vim.lsp.config["*"] = {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.config.mdx_analyzer = {
    cmd = { "mdx-analyzer", "--stdio" },
    filetypes = { "mdx" },
    root_dir = vim.fs.root(0, { "package.json", ".git", "node_modules" }),
    init_options = {
        typescript = {
            enabled = true,
        },
    },
}

vim.lsp.enable({
    "ts_ls",
    "html",
    "cssls",
    "lua_ls",
    "marksman",
    "jsonls",
    "gopls",
    "taplo",
    "astro",
    "mdx_analyzer",
})
