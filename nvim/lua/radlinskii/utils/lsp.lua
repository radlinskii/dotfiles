local M = {}

-- import cmp-nvim-lsp plugin
local cmp_nvim_lsp = require("cmp_nvim_lsp")

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
    keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>lx", "<cmd>LspRestart<CR>", opts) -- mapping to restart lsp if necessary

    opts.desc = "LSP document symbols"
    keymap.set("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols, opts)

    opts.desc = "LSP format"
    keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

    opts.desc = "LSP definition"
    keymap.set("n", "<leader>ld", require("telescope.builtin").lsp_definitions, opts)

    opts.desc = "LSP implementation"
    keymap.set("n", "<leader>li", require("telescope.builtin").lsp_implementations, opts)

    opts.desc = "LSP definition type"
    keymap.set("n", "<leader>lt", require("telescope.builtin").lsp_type_definitions, opts)

    opts.desc = "LSP references"
    keymap.set("n", "<leader>lr", require("telescope.builtin").lsp_references, opts)

    wk.add({ "<leader>lw", group = "LSP Workspace", icon = { cat = "filetype", name = ft }, buffer = bufnr })

    opts.desc = "LSP Add workspace folder"
    keymap.set("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)

    opts.desc = "LSP workspace symbols"
    keymap.set("n", "<leader>lws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)

    opts.desc = "LSP Remove workspace folder"
    keymap.set("n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)

    opts.desc = "LSP List workspace folders"
    keymap.set("n", "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
end

-- used to enable autocompletion (assign to every lsp server config)
M.capabilities = cmp_nvim_lsp.default_capabilities()

-- UFO: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

M.capabilities.textDocument.completion.completionItem = {
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
}

return M
