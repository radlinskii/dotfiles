local M = {}

-- import cmp-nvim-lsp plugin
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local wk = require("which-key")

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

M.on_attach = function(_, bufnr)
    opts.buffer = bufnr

    -- set keybinds

    -- Key mappings for Normal mode
    opts.desc = "Show LSP references"

    -- LSP mappings for Normal mode
    opts.desc = "LSP declaration"
    keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts)

    opts.desc = "LSP definition"
    keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

    opts.desc = "LSP hover"
    keymap.set("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

    opts.desc = "LSP implementation"
    keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

    opts.desc = "LSP signature help"
    keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    opts.desc = "LSP definition type"
    keymap.set("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

    opts.desc = "LSP based rename"
    keymap.set("n", "<leader>lm", vim.lsp.buf.rename, opts)

    opts.desc = "LSP formatting"
    keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

    opts.desc = "LSP references"
    keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

    opts.desc = "Diagnostic setloclist"
    keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

    wk.register({
        ["<leader>lw"] = {
            name = "LSP Workspace",
        },
    })

    opts.desc = "LSP Add workspace folder"
    keymap.set("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)

    opts.desc = "LSP Remove workspace folder"
    keymap.set("n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)

    opts.desc = "LSP List workspace folders"
    keymap.set("n", "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>lx", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

    -- LSP code action mapping for both Normal and Visual modes
    opts.desc = "LSP code action"
    keymap.set({ "n", "v" }, "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    wk.register({
        ["<leader>fl"] = {
            name = "Telescope LSP",
        },
    })
    -- not changed
    opts.desc = "Show Telescope LSP references"
    keymap.set("n", "<leader>flr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Show Telescope LSP definitions"
    keymap.set("n", "<leader>fld", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

    opts.desc = "Show Telescope LSP implementations"
    keymap.set("n", "<leader>fli", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

    opts.desc = "Show Telescope LSP type definitions"
    keymap.set("n", "<leader>flt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    opts.desc = "Show Telescope buffer diagnostics"
    keymap.set("n", "<leader>fld", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
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
