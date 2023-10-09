local cspell = require("cspell")
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local b = null_ls.builtins

local sources = {

    -- webdev stuff
    b.formatting.eslint,
    b.formatting.prettier,

    -- Lua
    b.formatting.stylua,

    -- cpp
    b.formatting.clang_format,

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
}

null_ls.setup({
    debug = true,
    sources = sources,
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
