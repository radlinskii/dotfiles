---@type LazyPluginSpec[]
return {
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = { "neovim/nvim-lspconfig", "folke/which-key.nvim" },
        opts = function()
            local on_attach = require("radlinskii.utils.lsp").on_attach
            local capabilities = require("radlinskii.utils.lsp").capabilities

            return {
                server = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                },
            }
        end,
        config = function(_, opts)
            require("rust-tools").setup(opts)
        end,
    },
    {

        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        config = function(_, opts)
            local crates = require("crates")
            crates.setup(opts)
            crates.show()
        end,
    },
}
