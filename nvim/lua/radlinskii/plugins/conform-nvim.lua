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
                html = { "prettier" },
                json = { "prettier" },
                json5 = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                lua = { "stylua" },
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
