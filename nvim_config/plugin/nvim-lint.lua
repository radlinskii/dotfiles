vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "BufEnter" }, {
    once = true,
    callback = function()
        vim.pack.add({ { src = "https://github.com/mfussenegger/nvim-lint" } })

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
            css = { "cspell", "stylelint" },
            scss = { "cspell", "stylelint" },
            sass = { "cspell", "stylelint" },
            astro = { "cspell", "stylelint", "eslint_d" },
            lua = { "cspell" },
            go = { "golangcilint" },
            htmldjango = { "djlint" },
            html = { "djlint" },
            ["*"] = { "cspell" },
        }

        lint.linters.markdownlint.args = {
            "--disable",
            "MD013",
            "MD030",
            "--",
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>rl", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
})
