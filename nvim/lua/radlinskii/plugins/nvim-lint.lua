---@type LazyPluginSpec
return {
    "mfussenegger/nvim-lint",
    dependencies = {
        "williamboman/mason.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local cspell_utils = require("radlinskii.utils.cspell")
        local lint = require("lint")
        local cspell = lint.linters.cspell

        table.insert(cspell.args, "-c")
        table.insert(cspell.args, cspell_utils.find_json())

        lint.linters_by_ft = {
            javascript = { "eslint_d", "cspell" },
            typescript = { "eslint_d", "cspell" },
            javascriptreact = { "eslint_d", "cspell" },
            typescriptreact = { "eslint_d", "cspell" },
            markdown = { "markdownlint", "cspell" },
            json = { "cspell" },
            json5 = { "cspell" },
            css = { "cspell" },
            lua = { "cspell" },
            go = { "golangcilint" },
            ["*"] = { "cspell" },
            -- shellcheck
        }

        lint.linters.markdownlint.args = {

            "--disable",
            "MD013", -- disable line length limit
            -- "MD024", -- allow multiple headings with the same comment
            "MD030", -- allow spaces after list markers
            -- "MD033", -- allow inline HTML
            -- "MD036", -- allow emphasis blocks
            -- "MD040", -- allow code blocks without language --[[ specification ]]
            -- "MD041", -- allow non-headers on the first line, e.g. meta section
            -- "MD046", -- allow mixed code-block styles
            "--",
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
                -- lint.try_lint("cspell")
            end,
        })

        vim.keymap.set("n", "<leader>rl", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
