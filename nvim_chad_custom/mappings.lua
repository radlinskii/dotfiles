---@type MappingsTable
local M = {}

M.general = {
    i = {},
    n = {
        -- switch between windows
        ["<C-u>"] = { "<C-w>k", "Window up" },
        ["<C-e>"] = { "<C-w>j", "Window down" },
        ["<C-n>"] = { "<C-w>h", "Window left" },
        ["<C-i>"] = { "<C-w>l", "Window right" },

        [";"] = { ":", "enter command mode", opts = { nowait = true } },

        ["u"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = { expr = true, noremap = true, silent = true },
        },
        ["e"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = { expr = true, noremap = true, silent = true },
        },
        ["<Up>"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = { expr = true, noremap = true, silent = true },
        },
        ["<Down>"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = { expr = true, noremap = true, silent = true },
        },
        ["n"] = { "h", "Move left", opts = { noremap = true, silent = true } },
        ["i"] = { "l", "Move right", opts = { noremap = true, silent = true } },
        ["N"] = { "H", "move to beginning of the visible screen", opts = { noremap = true, silent = true } },
        ["I"] = { "L", "move to beginning of the visible screen", opts = { noremap = true, silent = true } },
        ["h"] = { "i", "insert mode in place", opts = { noremap = true, silent = true } },
        ["H"] = {
            "I",
            "start insert mode at the non-blank spaced beginning of current line",
            opts = { noremap = true, silent = true },
        },
        ["k"] = { "u", "undo last change", opts = { noremap = true, silent = true } },
        ["K"] = { "U", "undo all changes", opts = { noremap = true, silent = true } },
        ["j"] = { "nzzzv", "find next appearance", opts = { noremap = true, silent = true } },
        ["J"] = { "Nzzzv", "find previous appearance", opts = { noremap = true, silent = true } },
        ["l"] = { "e", "go to end of the next word", opts = { noremap = true, silent = true } },
        ["L"] = { "E", "go to the end of the next non-blank spaced word", opts = { noremap = true, silent = true } },
        ["gl"] = { "ge", "go to end of the previous word", opts = { noremap = true, silent = true } },
        ["gL"] = { "gE", "go to end of the previous non-blank spaced word", opts = { noremap = true, silent = true } },
        ["E"] = { "J", "remove line break", opts = { noremap = true, silent = true } },

        ["<C-l>"] = {
            "<C-d>zz",
            "scroll half a window down and move cursor to the middle",
            opts = { noremap = true, silent = true },
        },
        ["<C-y>"] = {
            "<C-u>zz",
            "scroll half a window up and move cursor to the middle",
            opts = { noremap = true, silent = true },
        },
        ["<leader>rs"] = {
            [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
            "replace current word",
            opts = { noremap = true, silent = true },
        },

        ["<C-d>"] = {
            function()
                vim.diagnostic.goto_next({ float = { border = "rounded" } })
            end,
            "Go to next error",
            opts = { noremap = true, silent = true },
        },
        ["<C-S-d>"] = {
            function()
                vim.diagnostic.goto_prev({ float = { border = "rounded" } })
            end,
            "Go to prev error",
            opts = { noremap = true, silent = true },
        },
        ["<leader>fp"] = {
            "<cmd>Telescope diagnostics<CR>",
            "open telescope diagnostics",
        },
        ["<leader>ff"] = {
            "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
            "find files, including hidden files, but those in .git folder ",
            opts = { noremap = true, silent = true },
        },
    },
    v = {
        [">"] = { ">gv", "indent" },

        ["<Up>"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = { expr = true, noremap = true },
        },
        ["<Down>"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = { expr = true, noremap = true },
        },
        ["E"] = {
            ":m '>+1<CR>gv=gv",
            "move line up",
            opts = { noremap = true },
        },
        ["U"] = {
            ":m '<-2<CR>gv=gv",
            "move line down",
            opts = { noremap = true },
        },
    },
    x = {
        ["u"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = { expr = true, noremap = true },
        },
        ["e"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = { expr = true, noremap = true, silent = true },
        },
        ["<Up>"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = { expr = true, noremap = true },
        },
        ["<Down>"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = { expr = true, noremap = true },
        },
        ["n"] = { "h", "Move left", opts = { noremap = true } },
        ["i"] = { "l", "Move right", opts = { noremap = true } },

        ["N"] = { "H", "move to beginning of the visible screen", opts = { noremap = true } },
        ["I"] = { "L", "move to beginning of the visible screen", opts = { noremap = true } },
        ["h"] = { "i", "insert mode in place", opts = { noremap = true } },
        ["H"] = {
            "I",
            "start insert mode at the non-blank spaced beginning of current line",
            opts = { noremap = true },
        },
        ["k"] = { "u", "undo last change", opts = { noremap = true } },
        ["K"] = { "U", "undo all changes", opts = { noremap = true } },
        ["j"] = { "n", "find next appearance", opts = { noremap = true } },
        ["J"] = { "N", "find previous appearance", opts = { noremap = true } },
        ["l"] = { "e", "go to end of the next word", opts = { noremap = true } },
        ["L"] = { "E", "go to the end of the next non-blank spaced word", opts = { noremap = true } },
        ["gl"] = { "ge", "go to end of the previous word", opts = { noremap = true } },
        ["gL"] = { "gE", "go to end of the previous non-blank spaced word", opts = { noremap = true } },
        ["E"] = { "J", "remove line break", opts = { noremap = true } },
    },
    o = {
        ["u"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = { expr = true, noremap = true },
        },
        ["e"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = { expr = true, noremap = true, silent = true },
        },
        ["<Up>"] = {
            'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
            "Move up",
            opts = { expr = true, noremap = true },
        },
        ["<Down>"] = {
            'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
            "Move down",
            opts = { expr = true, noremap = true },
        },
        ["n"] = { "h", "Move left", opts = { noremap = true } },
        ["i"] = { "l", "Move right", opts = { noremap = true } },

        ["N"] = { "H", "move to beginning of the visible screen", opts = { noremap = true } },
        ["I"] = { "L", "move to beginning of the visible screen", opts = { noremap = true } },
        ["h"] = { "i", "insert mode in place", opts = { noremap = true } },
        ["H"] = {
            "I",
            "start insert mode at the non-blank spaced beginning of current line",
            opts = { noremap = true },
        },
        ["k"] = { "u", "undo last change", opts = { noremap = true } },
        ["K"] = { "U", "undo all changes", opts = { noremap = true } },
        ["j"] = { "n", "find next appearance", opts = { noremap = true } },
        ["J"] = { "N", "find previous appearance", opts = { noremap = true } },
        ["l"] = { "e", "go to end of the next word", opts = { noremap = true } },
        ["L"] = { "E", "go to the end of the next non-blank spaced word", opts = { noremap = true } },
        ["gl"] = { "ge", "go to end of the previous word", opts = { noremap = true } },
        ["gL"] = { "gE", "go to end of the previous non-blank spaced word", opts = { noremap = true } },
        ["E"] = { "J", "remove line break", opts = { noremap = true } },
    },
}

M.nvimtree = {
    n = {
        -- toggle
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
