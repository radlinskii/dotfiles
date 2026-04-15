---@type LazyPluginSpec

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "folke/which-key.nvim",
        "saghen/blink.cmp",
        "ibhagwan/fzf-lua",
    },
    config = function()
        vim.lsp.config["*"] = {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
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
        })
    end,
}
