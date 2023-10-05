local utils = require("custom.utils")

---@type MappingsTable
local M = {}

local defaultOpts = { noremap = true, silent = true }
local nonSilentOpts = { noremap = true }
local exprOpts = { noremap = true, expr = true, silent = true }

local colemakMappings = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = exprOpts },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = exprOpts },

    ["u"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = exprOpts },
    ["e"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = exprOpts },
    ["n"] = { "h", "Move left", opts = defaultOpts },
    ["i"] = { "l", "Move right", opts = defaultOpts },

    ["N"] = { "H", "Jump to beginning of the visible screen", opts = defaultOpts },
    ["I"] = { "L", "Jump to end of the visible screen", opts = defaultOpts },
    ["h"] = { "i", "Insert mode in place", opts = defaultOpts },
    ["H"] = { "I", "Start insert mode at the non-blank-spaced beginning of current line", opts = defaultOpts },
    ["k"] = { "u", "Undo last change", opts = defaultOpts },
    ["K"] = { "U", "Undo all changes", opts = defaultOpts },
    ["j"] = { "nzzzv", "Find next appearance", opts = defaultOpts },
    ["J"] = { "Nzzzv", "Find previous appearance", opts = defaultOpts },
    ["l"] = { "e", "Go to end of the next word", opts = defaultOpts },
    ["L"] = { "E", "Go to the end of the next non-blank-spaced word", opts = defaultOpts },
    ["E"] = { "J", "Remove line break", opts = defaultOpts },

    ["gE"] = { "gJ", "Remove line break without trimming whitespace", opts = defaultOpts },
    ["gl"] = { "ge", "Go to the end of the previous word", opts = defaultOpts },
    ["gL"] = { "gE", "Go to the end of the previous non-blank-spaced word", opts = defaultOpts },
    ["gH"] = { "gI", "Start insert mode at the 1st column", opts = defaultOpts },
    ["gh"] = { "gi", "Start insert mode at the last position in insert mode", opts = defaultOpts },
    ["gi"] = { "gh", "Start Select mode", opts = defaultOpts },
    ["gI"] = { "gH", "Start Select-Line mode", opts = defaultOpts },
    ["gj"] = { "gn", "find the next match and visually select it", opts = defaultOpts },
    ["gJ"] = { "gN", "find the previous match and visually select it", opts = defaultOpts },

    ["zN"] = { "zH", "Scroll left half a screenwidth", opts = defaultOpts },
    ["zn"] = { "zh", "Scroll N columns left", opts = defaultOpts },
    ["zI"] = { "zL", "Scroll right half a screenwidth", opts = defaultOpts },
    ["zi"] = { "zl", "Scroll N columns right", opts = defaultOpts },
    ["zl"] = { "zi", "Toggle foldenable", opts = defaultOpts },
    ["[F"] = { "zk", "Move to the end of the previous fold", opts = defaultOpts },
    ["]f"] = { "zj", "Move to the start of the next fold", opts = defaultOpts },

    ["<C-w>u"] = { "<C-w>k", "Focus window up", opts = defaultOpts },
    ["<C-w>e"] = { "<C-w>j", "Focus window down", opts = defaultOpts },
    ["<C-w>n"] = { "<C-w>h", "Focus window left", opts = defaultOpts },
    ["<C-w>i"] = { "<C-w>l", "Focus window right", opts = defaultOpts },

    ["<C-w>U"] = { "<C-w>K", "Move current window to the very top", opts = defaultOpts },
    ["<C-w>E"] = { "<C-w>J", "Move current window to the very bottom", opts = defaultOpts },
    ["<C-w>N"] = { "<C-w>H", "Move current window to the far left", opts = defaultOpts },
    ["<C-w>I"] = { "<C-w>L", "Move current window to the far right", opts = defaultOpts },

    ["<C-w>h"] = { "<C-w>i", "Split window and go to the declaration of item under the cursor", opts = defaultOpts },
    ["<C-w>l"] = { "<C-w>n", "Open new window", opts = defaultOpts },
}

local scrollMappings = {
    ["<C-d>"] = { "<C-d>zz", "Scroll half a window down and move cursor to the center", opts = defaultOpts },
    ["<C-u>"] = { "<C-u>zz", "Scroll half a window up and move cursor to the center", opts = defaultOpts },
    ["<PageUp>"] = { "<PageUp>zz", "Scroll a whole window up and move cursor to the center", opts = defaultOpts },
    ["<PageDown>"] = { "<PageDown>zz", "Scroll a whole window down and move cursor to the center", opts = defaultOpts },
}

local moveLinesMappings = {
    [">"] = { ">gv", "Increase indent", opts = defaultOpts },
    ["<"] = { "<gv", "Increase indent", opts = defaultOpts },

    ["E"] = { ":m '>+1<CR>gv=gv", "Move selected lines up", opts = defaultOpts },
    ["U"] = { ":m '<-2<CR>gv=gv", "Move selected lines down", opts = defaultOpts },
}

M.general = {
    i = {
        ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
        ["<C-f>"] = { "<End>", "End of line" },
        ["<C-l>"] = { "<C-f>", "Reindent line" },
    },
    n = vim.tbl_deep_extend("force", utils.copyTable(colemakMappings), utils.copyTable(scrollMappings), {
        ["<leader>rs"] = {
            [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
            "Substitute current word",
            opts = nonSilentOpts,
        },
    }),
    v = {},
    x = vim.tbl_deep_extend(
        "force",
        utils.copyTable(colemakMappings),
        utils.copyTable(scrollMappings),
        utils.copyTable(moveLinesMappings),
        {
            ["<leader>rs"] = {
                [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
                "Substitute current word",
                opts = nonSilentOpts,
            },
        }
    ),
    o = vim.tbl_deep_extend("force", utils.copyTable(colemakMappings), {}),
}

M.nvchad = {
    n = {
        ["<leader>,m"] = { "<cmd> NvCheatsheet <CR>", "Key mapping cheatsheet", opts = defaultOpts },
        ["<leader>,t"] = {
            function()
                require("base46").toggle_theme()
            end,
            "Toggle theme",
            opts = defaultOpts,
        },
        ["<leader>,f"] = { "<cmd> Telescope themes <CR>", "Nvchad themes", opts = defaultOpts },
        ["<leader>X"] = {
            function()
                require("nvchad.tabufline").closeAllBufs()
            end,
            "Close all buffers",
            opts = defaultOpts,
        },
    },
}

M.blankline = {
    n = {
        ["<leader>,c"] = {
            function()
                local ok, start = require("indent_blankline.utils").get_current_context(
                    vim.g.indent_blankline_context_patterns,
                    vim.g.indent_blankline_use_treesitter_scope
                )

                if ok then
                    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
                    vim.cmd([[normal! _]])
                end
            end,

            "Jump to current context",
        },
    },
}

M.nvimtree = {
    n = {
        ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree", opts = defaultOpts },
        ["<leader>E"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree", opts = defaultOpts },
    },
}

M.undotree = {
    n = {
        ["<leader>u"] = { "<cmd> UndotreeToggle <CR>", "Toggle undotree", opts = defaultOpts },
    },
}

M.fugitive = {
    n = {
        ["<leader>g"] = {
            function()
                local fugitive_buf_no = vim.fn.bufnr("^fugitive:")
                local buf_win_id = vim.fn.bufwinid(fugitive_buf_no)
                if fugitive_buf_no >= 0 and buf_win_id >= 0 then
                    vim.api.nvim_win_close(buf_win_id, false)
                else
                    vim.cmd(":G")
                end
            end,
            "Toggle fugitive",
            opts = defaultOpts,
        },
    },
}

M.lspconfig = {
    n = {
        ["<leader>lD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            "LSP declaration",
            opts = defaultOpts,
        },

        ["<leader>ld"] = {
            function()
                vim.lsp.buf.definition()
            end,
            "LSP definition",
            opts = defaultOpts,
        },

        ["<leader>lh"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "LSP hover",
            opts = defaultOpts,
        },

        ["<leader>li"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            "LSP implementation",
            opts = defaultOpts,
        },

        ["<leader>ls"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "LSP signature help",
            opts = defaultOpts,
        },

        ["<leader>lt"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
            "LSP definition type",
            opts = defaultOpts,
        },

        ["<leader>lm"] = {
            function()
                require("nvchad.renamer").open()
            end,
            "LSP based rename",
            opts = defaultOpts,
        },

        ["<leader>lg"] = {
            function()
                vim.lsp.buf.format({ async = true })
            end,
            "LSP formatting",
        },

        ["<leader>la"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "LSP code action",
            opts = defaultOpts,
        },

        ["<leader>lr"] = {
            function()
                vim.lsp.buf.references()
            end,
            "LSP references",
            opts = defaultOpts,
        },

        ["<leader>lf"] = {
            function()
                vim.diagnostic.open_float({ border = "rounded" })
            end,
            "Floating diagnostic",
            opts = defaultOpts,
        },

        ["[d"] = {
            function()
                vim.diagnostic.goto_prev({ float = { border = "rounded" } })
            end,
            "Go to prev diagnostic",
            opts = defaultOpts,
        },

        ["]d"] = {
            function()
                vim.diagnostic.goto_next({ float = { border = "rounded" } })
            end,
            "Go to next diagnostic",
            opts = defaultOpts,
        },

        ["<leader>lq"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            "Diagnostic setloclist",
            opts = defaultOpts,
        },

        ["<leader>lwa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            "LSP Add workspace folder",
            opts = defaultOpts,
        },

        ["<leader>lwr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            "LSP Remove workspace folder",
            opts = defaultOpts,
        },

        ["<leader>lwl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "LSP List workspace folders",
            opts = defaultOpts,
        },
    },

    v = {
        ["<leader>la"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "LSP code action",
            opts = defaultOpts,
        },
    },
}

M.telescope = {
    n = {
        ["<leader>ff"] = {
            "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '--follow', '-g', '!.git' }})<CR>",
            "Find files, including hidden files, but those in .git folder ",
            opts = defaultOpts,
        },
        ["<leader>fo"] = {
            "<cmd> lua require('telescope.builtin').oldfiles({cwd_only = true}) <CR>",
            "Find oldfiles from CWD",
            opts = defaultOpts,
        },
        ["<leader>fO"] = {
            "<cmd> lua require('telescope.builtin').oldfiles({cwd_only = false}) <CR>",
            "Find global vim oldfiles",
            opts = defaultOpts,
        },
        ["<leader>fr"] = { "<cmd> Telescope lsp_references <CR>", "Find LSP references", opts = defaultOpts },
        ["<leader>fp"] = { "<cmd> Telescope diagnostics <CR>", "Open telescope diagnostics", opts = defaultOpts },
        ["<leader>fm"] = { "<cmd> Telescope marks <CR>", "Telescope bookmarks", opts = defaultOpts },
        ["<leader>fgc"] = { "<cmd> Telescope git_commits <CR>", "Git commits", opts = defaultOpts },
        ["<leader>fgs"] = { "<cmd> Telescope git_status <CR>", "Git status", opts = defaultOpts },
        ["<leader>fgb"] = { "<cmd> Telescope git_branches <CR>", "Git branches", opts = defaultOpts },
        ["<leader>fgz"] = { "<cmd> Telescope git_stash <CR>", "Git stashes", opts = defaultOpts },
        ["<leader>ft"] = { "<cmd> Telescope terms <CR>", "Pick hidden term", opts = defaultOpts },
        ["<leader>fth"] = { "<cmd> Telescope themes <CR>", "Nvchad themes", opts = defaultOpts },
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
            opts = defaultOpts,
        },
        ["<leader>ho"] = {
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            "Open Harpoon quick menu",
            opts = defaultOpts,
        },
        ["<leader>hi"] = {
            function()
                require("harpoon.ui").nav_next()
            end,
            "Navigate to next mark in harpoon",
            opts = defaultOpts,
        },
        ["<leader>hn"] = {
            function()
                require("harpoon.ui").nav_prev()
            end,
            "Navigate to prev mark in harpoon",
            opts = defaultOpts,
        },
        ["<leader>ht"] = {
            function()
                require("harpoon.ui").nav_file(1)
            end,
            "Navigate to 1st mark in harpoon",
            opts = defaultOpts,
        },
        ["<leader>hs"] = {
            function()
                require("harpoon.ui").nav_file(2)
            end,
            "Navigate to 2nd mark in harpoon",
            opts = defaultOpts,
        },
        ["<leader>hr"] = {
            function()
                require("harpoon.ui").nav_file(3)
            end,
            "Navigate to 3rd mark in harpoon",
            opts = defaultOpts,
        },
        ["<leader>hp"] = {
            function()
                require("harpoon.ui").nav_file(4)
            end,
            "Navigate to 4th mark in harpoon",
            opts = defaultOpts,
        },
        ["<leader>hf"] = {
            function()
                require("harpoon.ui").nav_file(5)
            end,
            "Navigate to 5th mark in harpoon",
            opts = defaultOpts,
        },
        ["<leader>hw"] = {
            function()
                require("harpoon.ui").nav_file(6)
            end,
            "Navigate to 6th mark in harpoon",
            opts = defaultOpts,
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
            opts = exprOpts,
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
            "Jump to previous hunk",
            opts = exprOpts,
        },

        ["<leader>cp"] = {
            "<cmd>Gitsigns preview_hunk<CR>",
            "Preview hunk",
            opts = defaultOpts,
        },

        ["<leader>cb"] = {
            "<cmd>Gitsigns blame_line<CR>",
            "Blame line",
            opts = defaultOpts,
        },

        ["<leader>cs"] = {
            "<cmd>Gitsigns stage_hunk<CR>",
            "Stage hunk",
            opts = defaultOpts,
        },

        ["<leader>cu"] = {
            "<cmd>Gitsigns undo_stage_hunk<CR>",
            "Undo stage hunk",
            opts = defaultOpts,
        },

        ["<leader>ca"] = {
            "<cmd>Gitsigns stage_buffer<CR>",
            "Stage buffer",
            opts = defaultOpts,
        },

        ["<leader>cr"] = {
            "<cmd>Gitsigns reset_hunk<CR>",
            "Reset hunk",
            opts = defaultOpts,
        },

        ["<leader>cR"] = {
            "<cmd>Gitsigns reset_buffer<CR>",
            "Reset buffer",
            opts = defaultOpts,
        },

        ["<leader>cd"] = {
            "<cmd>Gitsigns toggle_deleted<CR>",
            "Toggle deleted",
            opts = defaultOpts,
        },

        ["<leader>cc"] = {
            "<cmd>Gitsigns<CR>",
            "Call GitSigns command",
            opts = defaultOpts,
        },
    },
    x = {
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
            opts = exprOpts,
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
            "Jump to previous hunk",
            opts = exprOpts,
        },

        ["<leader>cp"] = {
            "<cmd>'<,'>Gitsigns preview_hunk<CR>",
            "Preview hunk",
            opts = defaultOpts,
        },

        ["<leader>cs"] = {
            "<cmd>'<,'>Gitsigns stage_hunk<CR>",
            "Stage hunk",
            opts = defaultOpts,
        },

        ["<leader>cu"] = {
            "<cmd>'<,'>Gitsigns undo_stage_hunk<CR>",
            "Undo stage hunk",
            opts = defaultOpts,
        },

        ["<leader>cr"] = {
            "<cmd>'<,'>Gitsigns reset_hunk<CR>",
            "Reset hunk",
            opts = defaultOpts,
        },

        ["<leader>cc"] = {
            "<cmd>'<,'>Gitsigns<CR>",
            "Call GitSigns command on selection",
            opts = defaultOpts,
        },
    },
}

M.ctrlsf = {
    n = {
        ["<leader>sf"] = { "<Plug>CtrlSFPrompt", "Provide a phrase to search for", opts = nonSilentOpts },
        ["<leader>ss"] = {
            "<Plug>CtrlSFCwordPath",
            "Provide a phrase to search for word under the cursor",
            opts = nonSilentOpts,
        },
        ["<leader>sw"] = {
            "<Plug>CtrlSFCCwordPath",
            "Provide a phrase to search for word under the cursor with boundaries",
            opts = nonSilentOpts,
        },
        ["<leader>sp"] = {
            "<Plug>CtrlSFPwordPath",
            "Provide a phrase to search for the last searched word in vim",
            opts = nonSilentOpts,
        },
        ["<leader>so"] = { ":CtrlSFOpen<cr>", "Open/Toggle CtrlSF window", opts = defaultOpts },
        ["<leader>st"] = { ":CtrlSFToggle<cr>", "Toggle CtrlSF window", opts = defaultOpts },
    },
    v = {
        ["<leader>sf"] = {
            "<Plug>CtrlSFVwordPath",
            "Provide currently visually selected word to search for",
            opts = nonSilentOpts,
        },
    },
}

M.ufo = {
    n = {
        ["zR"] = {
            function()
                require("ufo").openAllFolds()
            end,
            "Open all folds",
            opts = defaultOpts,
        },
        ["zM"] = {
            function()
                require("ufo").closeAllFolds()
            end,
            "Open all folds",
            opts = defaultOpts,
        },
        ["[f"] = {
            function()
                require("ufo").goPreviousStartFold()
            end,
            "Move to start of previous fold",
            opts = defaultOpts,
        },
        ["[w"] = {
            function()
                require("ufo").goPreviousClosedFold()
            end,
            "Move to previous closed fold",
            opts = defaultOpts,
        },
        ["]w"] = {
            function()
                require("ufo").goNextClosedFold()
            end,
            "Move to next closed fold",
            opts = defaultOpts,
        },
        ["zh"] = {
            function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end,
            "Peek folded lines under current cursor",
            opts = defaultOpts,
        },
    },
}

M.diffview = {
    n = {
        ["<leader>dc"] = { "<cmd>DiffviewClose<CR>", "Close Diffview", opts = defaultOpts },
        ["<leader>do"] = { "<cmd>DiffviewOpen<CR>", "Open Diffview", opts = defaultOpts },
        ["<leader>dh"] = { "<cmd>DiffviewFileHistory %<CR>", "Open file history Diffview", opts = defaultOpts },
    },
}

M.disabled = {
    n = {
        -- nvchad linenumbers
        ["<leader>n"] = "",
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
        ["<leader>/"] = "",

        -- defalult mappings
        ["zh"] = "",
        ["zH"] = "",
    },
    v = {
        ["<leader>/"] = "",
    },
    i = {
        ["<C-h>"] = "",
        ["<C-j>"] = "",
        ["<C-l>"] = "",
        ["<C-k>"] = "",
        ["<C-b>"] = "",
        ["<C-e>"] = "",
    },
}

return M
