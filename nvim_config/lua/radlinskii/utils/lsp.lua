local M = {}

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

M.on_attach = function(_, bufnr)
    local wk = require("which-key")
    opts.buffer = bufnr

    local ft = vim.bo.filetype

    -- set keybinds
    wk.add({ "<leader>l", group = "LSP", icon = { cat = "filetype", name = ft }, buffer = bufnr })

    -- LSP mappings for Normal mode
    opts.desc = "LSP declaration"
    keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts)

    opts.desc = "LSP hover"
    keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)

    opts.desc = "LSP based rename"
    keymap.set("n", "<leader>lm", vim.lsp.buf.rename, opts)

    opts.desc = "LSP signature help"
    keymap.set("n", "<leader>lS", vim.lsp.buf.signature_help, opts)

    -- LSP code action mapping for both Normal and Visual modes
    opts.desc = "LSP code action"
    keymap.set({ "n", "v" }, "<leader>la", function()
        require("fzf-lua").register_ui_select(function(_, items)
            local min_h, max_h = 0.15, 0.70
            local h = (#items + 4) / vim.o.lines
            if h < min_h then
                h = min_h
            elseif h > max_h then
                h = max_h
            end
            return { winopts = { height = h, width = 0.60, row = 0.40 } }
        end)

        vim.lsp.buf.code_action()
    end, opts)

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>lx", "<cmd>LspRestart<CR>", opts) -- mapping to restart lsp if necessary

    opts.desc = "LSP document symbols"
    keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", opts)

    opts.desc = "LSP format"
    keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

    opts.desc = "LSP definition"
    keymap.set("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", opts)

    opts.desc = "LSP implementation"
    keymap.set("n", "<leader>li", "<cmd>FzfLua lsp_implementations <CR>", opts)

    opts.desc = "LSP definition type"
    keymap.set("n", "<leader>lt", "<cmd>FzfLua lsp_typedefs<CR>", opts)

    opts.desc = "LSP references"
    keymap.set("n", "<leader>lr", "<cmd>FzfLua lsp_references<CR>", opts)

    wk.add({ "<leader>lw", group = "LSP Workspace", icon = { cat = "filetype", name = ft }, buffer = bufnr })

    opts.desc = "LSP Add workspace folder"
    keymap.set("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)

    opts.desc = "LSP workspace symbols"
    keymap.set("n", "<leader>lws", "<cmd>FzfLua lsp_workspace_symbols<CR>", opts)

    opts.desc = "LSP Remove workspace folder"
    keymap.set("n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)

    opts.desc = "LSP List workspace folders"
    keymap.set("n", "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
end

M.capabilities = {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        },
        completion = {
            completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                    properties = {
                        "documentation",
                        "detail",
                        "additionalTextEdits",
                    },
                },
            },
        },
    },
}

return M
