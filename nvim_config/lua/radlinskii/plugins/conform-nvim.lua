---@type LazyPluginSpec
return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                sass = { "prettier" },
                html = { "prettier" },
                htmldjango = { "djlint" },
                json = { "prettier" },
                json5 = { "prettier" },
                yaml = { "prettier" },
                markdown = { "markdownlint" },
                graphql = { "prettier" },
                lua = { "stylua" },
                go = { "gofumpt", "goimports", "gomodifytags", "golines" },
                astro = { "prettier" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1500,
            },
        })

        vim.keymap.set({ "x" }, "<leader>rf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1500,
            })
        end, { desc = "Format range", noremap = true, silent = true })

        vim.keymap.set({ "n" }, "<leader>rf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1500,
            })
        end, { desc = "Format file", noremap = true, silent = true })
    end,
}
