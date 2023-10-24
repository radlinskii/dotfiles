return {
    "nvimtools/none-ls.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "davidmh/cspell.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local mason_null_ls = require("mason-null-ls")

        mason_null_ls.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "eslint", -- js linter
                "markdownlint",
            },
        })

        local cspell = require("cspell")
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local null_ls_utils = require("null-ls.utils")

        local b = null_ls.builtins

        local sources = {
            b.formatting.eslint,
            b.formatting.prettier,

            b.formatting.stylua,

            b.formatting.shfmt.with({ filetypes = { "bash", "sh", "zsh" } }),
            b.diagnostics.shellcheck.with({
                filetypes = { "bash", "sh", "zsh" },
                args = { "--format", "json1", "--source-path=$DIRNAME", "--shell=bash", "--external-sources", "-" },
            }),
            b.code_actions.shellcheck.with({
                filetypes = { "bash", "sh", "zsh" },
                args = { "--format", "json1", "--source-path=$DIRNAME", "--shell=bash", "--external-sources", "-" },
            }),

            cspell.diagnostics,
            cspell.code_actions,

            b.diagnostics.markdownlint,
        }

        null_ls.setup({
            debug = true,
            sources = sources,
            -- add package.json as identifier for root (for typescript monorepos)
            root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })
    end,
}
