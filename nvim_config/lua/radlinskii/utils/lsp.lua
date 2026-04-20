local M = {}

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

M.on_attach = function(args)
    local wk = require("which-key")
    opts.buffer = args.buf

    local ft = vim.bo.filetype

    -- set keybinds
    wk.add({ "<leader>l", group = "LSP", icon = { cat = "filetype", name = ft }, buffer = args.buf })

    -- LSP mappings for Normal mode
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
    keymap.set("n", "<leader>lx", "<cmd>lsp restart<CR>", opts) -- mapping to restart lsp if necessary

    opts.desc = "LSP document symbols"
    keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", opts)

    opts.desc = "LSP format"
    keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

    opts.desc = "LSP definitions"
    keymap.set("n", "<leader>ld", function()
        require("fzf-lua").lsp_definitions({ jump1 = true })
    end, opts)

    opts.desc = "LSP Definitions"
    keymap.set("n", "<leader>lD", function()
        require("fzf-lua").lsp_definitions({ jump1 = false })
    end, opts)

    opts.desc = "LSP implementation"
    keymap.set("n", "<leader>li", function()
        require("fzf-lua").lsp_implementations({ jump1 = true })
    end, opts)

    opts.desc = "LSP Implementations"
    keymap.set("n", "<leader>lI", function()
        require("fzf-lua").lsp_implementations({ jump1 = false })
    end, opts)

    opts.desc = "LSP definition type"
    keymap.set("n", "<leader>lt", function()
        require("fzf-lua").lsp_typedefs({ jump1 = true })
    end, opts)

    opts.desc = "LSP Definition types"
    keymap.set("n", "<leader>lT", function()
        require("fzf-lua").lsp_typedefs({ jump1 = false })
    end, opts)

    opts.desc = "LSP references"
    keymap.set("n", "<leader>lr", function()
        require("fzf-lua").lsp_references({ jump1 = true })
    end, opts)

    opts.desc = "LSP References"
    keymap.set("n", "<leader>lR", function()
        require("fzf-lua").lsp_references({ jump1 = false })
    end, opts)

    wk.add({ "<leader>lw", group = "LSP Workspace", icon = { cat = "filetype", name = ft }, buffer = args.buf })

    opts.desc = "LSP Add workspace folder"
    keymap.set("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)

    opts.desc = "LSP workspace symbols"
    keymap.set("n", "<leader>lws", "<cmd>FzfLua lsp_workspace_symbols<CR>", opts)

    opts.desc = "LSP Remove workspace folder"
    keymap.set("n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)

    opts.desc = "LSP List workspace folders"
    keymap.set("n", "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
end

return M
