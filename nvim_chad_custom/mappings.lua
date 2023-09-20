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

    ["N"] = { "H", "Jump to beginning of the visible screen", opts = noremapOpts },
    ["I"] = { "L", "Jump to end of the visible screen", opts = noremapOpts },
    ["h"] = { "i", "Insert mode in place", opts = noremapOpts },
    ["H"] = { "I", "Start insert mode at the non-blank spaced beginning of current line", opts = noremapOpts },
    ["k"] = { "u", "Undo last change", opts = noremapOpts },
    ["K"] = { "U", "Undo all changes", opts = noremapOpts },
    ["j"] = { "nzzzv", "Find next appearance", opts = noremapOpts },
    ["J"] = { "Nzzzv", "Find previous appearance", opts = noremapOpts },
    ["l"] = { "e", "Go to end of the next word", opts = noremapOpts },
    ["L"] = { "E", "Go to the end of the next non-blank spaced word", opts = noremapOpts },
    ["E"] = { "J", "Remove line break", opts = noremapOpts },

    ["<C-d>"] = { "<C-d>zz", "Scroll half a window down and move cursor to the middle", opts = noremapOpts },
    ["<C-u>"] = { "<C-u>zz", "Scroll half a window up and move cursor to the middle", opts = noremapOpts },
    ["<PageUp>"] = { "<PageUp>zz", "Scroll a whole window up and move cursor to the middle", opts = noremapOpts },
    ["<PageDown>"] = {
        "<PageDown>zz",
        "Scroll a whole window down and move cursor to the middle",
        opts = noremapOpts,
    },
}

M.general = {
    i = {},
    n = vim.tbl_deep_extend("force", utils.copyTable(colemakMappings), {
        [";"] = { ":", "Enter command mode", noremapNowaitOpts },

        ["<C-w>u"] = { "<C-w>k", "Window up", opts = noremapOpts },
        ["<C-w>e"] = { "<C-w>j", "Window down", opts = noremapOpts },
        ["<C-w>n"] = { "<C-w>h", "Window left", opts = noremapOpts },
        ["<C-w>i"] = { "<C-w>l", "Window right", opts = noremapOpts },

        ["<leader>rs"] = {
            [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
            "Substitute current word",
            opts = noremapOpts,
        },
        ["<leader>km"] = { "<cmd> NvCheatsheet <CR>", "Key mapping cheatsheet", opts = noremapOpts },
    }),
    v = {
        [">"] = { ">gv", "Increase indent", opts = noremapOpts },
        ["<"] = { "<gv", "Increase indent", opts = noremapOpts },

        ["E"] = { ":m '>+1<CR>gv=gv", "Move selected lines up", opts = noremapOpts },
        ["U"] = { ":m '<-2<CR>gv=gv", "Move selected lines down", opts = noremapOpts },
    },
    x = vim.tbl_deep_extend("force", utils.copyTable(colemakMappings), {
        ["E"] = { ":m '>+1<CR>gv=gv", "Move selected lines up", opts = noremapOpts },
        ["U"] = { ":m '<-2<CR>gv=gv", "Move selected lines down", opts = noremapOpts },
    }),
    o = vim.tbl_deep_extend("force", utils.copyTable(colemakMappings), {}),
}

M.nvimtree = {
    n = {
        ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree", opts = noremapOpts },
    },
}

M.lspconfig = {
    n = {
        ["<leader>lD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            "LSP declaration",
            opts = noremapOpts,
        },

        ["<leader>ld"] = {
            function()
                vim.lsp.buf.definition()
            end,
            "LSP definition",
            opts = noremapOpts,
        },

        ["<leader>lh"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "LSP hover",
            opts = noremapOpts,
        },

        ["<leader>li"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            "LSP implementation",
            opts = noremapOpts,
        },

        ["<leader>ls"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "LSP signature help",
            opts = noremapOpts,
        },

        ["<leader>lt"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
            "LSP definition type",
            opts = noremapOpts,
        },

        ["<leader>lm"] = {
            function()
                require("nvchad.renamer").open()
            end,
            "LSP based rename",
            opts = noremapOpts,
        },

        ["<leader>la"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "LSP code action",
            opts = noremapOpts,
        },

        ["<leader>lr"] = {
            function()
                vim.lsp.buf.references()
            end,
            "LSP references",
            opts = noremapOpts,
        },

        ["<leader>lf"] = {
            function()
                vim.diagnostic.open_float({ border = "rounded" })
            end,
            "Floating diagnostic",
            opts = noremapOpts,
        },

        ["[d"] = {
            function()
                vim.diagnostic.goto_prev({ float = { border = "rounded" } })
            end,
            "Go to prev diagnostic",
            opts = noremapOpts,
        },

        ["]d"] = {
            function()
                vim.diagnostic.goto_next({ float = { border = "rounded" } })
            end,
            "Go to next diagnostic",
            opts = noremapOpts,
        },

        ["<leader>lq"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            "Diagnostic setloclist",
            opts = noremapOpts,
        },

        ["<leader>lwa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            "LSP Add workspace folder",
            opts = noremapOpts,
        },

        ["<leader>lwr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            "LSP Remove workspace folder",
            opts = noremapOpts,
        },

        ["<leader>lwl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "LSP List workspace folders",
            opts = noremapOpts,
        },
    },

    v = {
        ["<leader>la"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "LSP code action",
            opts = noremapOpts,
        },
    },
}

M.telescope = {
    n = {
        ["<leader>ff"] = {
            "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '--follow', '-g', '!.git' }})<CR>",
            "Find files, including hidden files, but those in .git folder ",
            opts = noremapOpts,
        },
        ["<leader>fr"] = { "<cmd> Telescope lsp_references <CR>", "Find LSP references", opts = noremapOpts },
        ["<leader>fp"] = { "<cmd> Telescope diagnostics <CR>", "Open telescope diagnostics", opts = noremapOpts },
        ["<leader>fm"] = { "<cmd> Telescope marks <CR>", "Telescope bookmarks", opts = noremapOpts },
        ["<leader>fgc"] = { "<cmd> Telescope git_commits <CR>", "Git commits", opts = noremapOpts },
        ["<leader>fgs"] = { "<cmd> Telescope git_status <CR>", "Git status", opts = noremapOpts },
        ["<leader>fgb"] = { "<cmd> Telescope git_branches <CR>", "Git branches", opts = noremapOpts },
        ["<leader>ft"] = { "<cmd> Telescope terms <CR>", "Pick hidden term", opts = noremapOpts },
        ["<leader>fth"] = { "<cmd> Telescope themes <CR>", "Nvchad themes", opts = noremapOpts },
    },
}

M.harpoon = {
    n = {
        --Harpoon
        ["<leader>hm"] = {
            function()
                require("harpoon.mark").add_file()
            end,
            "Mark using harpoon",
            opts = noremapOpts,
        },
        ["<leader>ho"] = {
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            "Open Harpoon quick menu",
            opts = noremapOpts,
        },
        ["<leader>hi"] = {
            function()
                require("harpoon.ui").nav_next()
            end,
            "Navigate to next mark in harpoon",
            opts = noremapOpts,
        },
        ["<leader>hn"] = {
            function()
                require("harpoon.ui").nav_prev()
            end,
            "Navigate to prev mark in harpoon",
            opts = noremapOpts,
        },
        ["<leader>ht"] = {
            function()
                require("harpoon.ui").nav_file(1)
            end,
            "Navigate to 1st mark in harpoon",
            opts = noremapOpts,
        },
        ["<leader>hs"] = {
            function()
                require("harpoon.ui").nav_file(2)
            end,
            "Navigate to 2nd mark in harpoon",
            opts = noremapOpts,
        },
        ["<leader>hr"] = {
            function()
                require("harpoon.ui").nav_file(3)
            end,
            "Navigate to 3rd mark in harpoon",
            opts = noremapOpts,
        },
        ["<leader>hp"] = {
            function()
                require("harpoon.ui").nav_file(4)
            end,
            "Navigate to 4th mark in harpoon",
            opts = noremapOpts,
        },
        ["<leader>hf"] = {
            function()
                require("harpoon.ui").nav_file(5)
            end,
            "Navigate to 5th mark in harpoon",
            opts = noremapOpts,
        },
        ["<leader>hw"] = {
            function()
                require("harpoon.ui").nav_file(6)
            end,
            "Navigate to 6th mark in harpoon",
            opts = noremapOpts,
        },
    },
}

M.gitsigns = {
    n = {
        ["]c"] = {
            function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    require("gitsigns").next_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to next hunk",
            opts = noremapExprOpts,
        },

        ["[c"] = {
            function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    require("gitsigns").prev_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to prev hunk",
            opts = noremapExprOpts,
        },

        ["<leader>cp"] = {
            function()
                require("gitsigns").preview_hunk()
            end,
            "Preview hunk",
            opts = noremapOpts,
        },

        ["<leader>cb"] = {
            function()
                require("gitsigns").blame_line()
            end,
            "Blame line",
            opts = noremapOpts,
        },

        ["<leader>cs"] = {
            function()
                require("gitsigns").stage_hunk()
            end,
            "Stage hunk",
            opts = noremapOpts,
        },

        ["<leader>cu"] = {
            function()
                require("gitsigns").undo_stage_hunk()
            end,
            "Undo stage hunk",
            opts = noremapOpts,
        },

        ["<leader>ca"] = {
            function()
                require("gitsigns").stage_buffer()
            end,
            "Stage buffer",
            opts = noremapOpts,
        },

        ["<leader>cr"] = {
            function()
                require("gitsigns").reset_hunk()
            end,
            "Reset hunk",
            opts = noremapOpts,
        },

        ["<leader>cR"] = {
            function()
                require("gitsigns").reset_buffer()
            end,
            "Reset buffer",
            opts = noremapOpts,
        },

        ["<leader>cd"] = {
            function()
                require("gitsigns").toggle_deleted()
            end,
            "Toggle deleted",
            opts = noremapOpts,
        },
    },
}

M.disabled = {
    n = {
        -- nvchad cheatsheet
        ["<leader>ch"] = "",

        -- nvimtree nvchad
        ["<C-n>"] = "",

        -- terminal nvchad defaults
        ["<leader>h"] = "",
        ["<leader>v"] = "",

        -- gitsigns nvchad defaults
        ["<leader>rh"] = "",
        ["<leader>ph"] = "",
        ["<leader>gb"] = "",
        ["<leader>td"] = "",

        -- telescope nvchad defaults
        ["<leader>ma"] = "",
        ["<leader>cm"] = "",
        ["<leader>gt"] = "",
        ["<leader>pt"] = "",
        ["<leader>th"] = "",

        -- lsp nvchad defaults
        ["gD"] = "",
        ["gd"] = "",
        ["K"] = "",
        ["gi"] = "",
        ["<leader>D"] = "",
        ["<leader>ra"] = "",
        ["<leader>ca"] = "",
        ["gr"] = "",
        ["<leader>f"] = "",
        ["<leader>q"] = "",
        ["<leader>wa"] = "",
        ["<leader>wr"] = "",
        ["<leader>wl"] = "",
        ["gh"] = "",
    },
}

return M
