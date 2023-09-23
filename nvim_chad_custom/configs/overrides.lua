local M = {}

M.treesitter = {
    ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "markdown",
        "markdown_inline",
    },
}

local actions = require("telescope.actions")
M.telescope = {
    defaults = {
        mappings = {
            i = {
                ["<C-l>"] = actions.cycle_history_next,
                ["<C-y>"] = actions.cycle_history_prev,
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-h>"] = actions.select_horizontal,
                ["<C-g>"] = actions.complete_tag,
            },
            n = {
                ["<C-l>"] = actions.cycle_history_next,
                ["<C-y>"] = actions.cycle_history_prev,
                ["<C-h>"] = actions.select_horizontal,
                ["e"] = actions.move_selection_next,
                ["u"] = actions.move_selection_previous,
                ["N"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["I"] = actions.move_to_bottom,
            },
        },
    },
}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",

        -- c/cpp stuff
        "clangd",
        "clang-format",
    },
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true,
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
            },
        },
    },
    view = {
        side = "right",
    },
}

M.cmp = {
    sources = {
        { name = "crates" },
    },
    mapping = {
        ["<C-S-Space>"] = require("cmp").mapping.complete(),
    },
}

M.gitsigns = {
    signs = {
        add = { text = "▌" },
        change = { text = "▌" },
        delete = { text = "▶" },
        topdelete = { text = "◤" },
        changedelete = { text = "▌" },
        untracked = { text = "▌" },
    },
}

return M
