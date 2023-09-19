local utils = require("custom.utils")

---@type MappingsTable
local M = {}

local noremapOpts = { noremap = true, silent = true }
local noremapExprOpts = { noremap = true, expr = true, silent = true }
local noremapNowaitOpts = { noremap = true, nowait = true }

local colemakMappings = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = noremapExprOpts },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = noremapExprOpts },

    ["u"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = noremapExprOpts },
    ["e"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = noremapExprOpts },
    ["n"] = { "h", "Move left", opts = noremapOpts },
    ["i"] = { "l", "Move right", opts = noremapOpts },

    ["N"] = { "H", "move to beginning of the visible screen", opts = noremapOpts },
    ["I"] = { "L", "move to beginning of the visible screen", opts = noremapOpts },
    ["h"] = { "i", "insert mode in place", opts = noremapOpts },
    ["H"] = { "I", "start insert mode at the non-blank spaced beginning of current line", opts = noremapOpts },
    ["k"] = { "u", "undo last change", opts = noremapOpts },
    ["K"] = { "U", "undo all changes", opts = noremapOpts },
    ["j"] = { "nzzzv", "find next appearance", opts = noremapOpts },
    ["J"] = { "Nzzzv", "find previous appearance", opts = noremapOpts },
    ["l"] = { "e", "go to end of the next word", opts = noremapOpts },
    ["L"] = { "E", "go to the end of the next non-blank spaced word", opts = noremapOpts },
    ["E"] = { "J", "remove line break", opts = noremapOpts },

    ["<C-l>"] = { "<C-d>zz", "scroll half a window down and move cursor to the middle", opts = noremapOpts },
    ["<C-y>"] = { "<C-u>zz", "scroll half a window up and move cursor to the middle", opts = noremapOpts },
    ["<PageUp>"] = { "<PageUp>zz", "scroll a whole window up and move cursor to the middle", opts = noremapOpts },
    ["<PageDown>"] = {
        "<PageDown>zz",
        "scroll a whole window down and move cursor to the middle",
        opts = noremapOpts,
    },
}

M.general = {
    i = {},
    n = vim.tbl_deep_extend("force", utils.copyTable(colemakMappings), {
        [";"] = { ":", "enter command mode", noremapNowaitOpts },

        ["<C-u>"] = { "<C-w>k", "Window up" },
        ["<C-e>"] = { "<C-w>j", "Window down" },
        ["<C-n>"] = { "<C-w>h", "Window left" },
        ["<C-i>"] = { "<C-w>l", "Window right" },

        ["<leader>rs"] = {
            [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
            "replace the whole current word",
            opts = noremapOpts,
        },

        ["<C-d>"] = {
            function()
                vim.diagnostic.goto_next({ float = { border = "rounded" } })
            end,
            "Go to next error",
            opts = noremapOpts,
        },
        ["<C-S-d>"] = {
            function()
                vim.diagnostic.goto_prev({ float = { border = "rounded" } })
            end,
            "Go to prev error",
            opts = noremapOpts,
        },
        ["<leader>fp"] = { "<cmd>Telescope diagnostics<CR>", "open telescope diagnostics", opts = noremapOpts },

        ["<leader>ff"] = {
            "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
            "find files, including hidden files, but those in .git folder ",
            opts = noremapOpts,
        },
    }),
    v = {
        [">"] = { ">gv", "indent" },

        ["E"] = { ":m '>+1<CR>gv=gv", "move selected lines up", opts = noremapOpts },
        ["U"] = { ":m '<-2<CR>gv=gv", "move selected lines down", opts = noremapOpts },
    },
    x = vim.tbl_deep_extend("force", utils.copyTable(colemakMappings), {}),
    o = vim.tbl_deep_extend("force", utils.copyTable(colemakMappings), {}),
}

M.nvimtree = {
    n = {
        ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    },
}

M.lspconfig = {
    n = {
        ["gh"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "LSP hover",
        },
    },
}

M.crates = {
    n = {
        ["<leader>rcu"] = {
            function()
                require("crates").upgrade_all_crates()
            end,
            "update all crates",
        },
    },
}

return M
