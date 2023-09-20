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
    indent = {
        enable = true,
        -- disable = {
        --   "python"
        -- },
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
    experimental = {
        ghost_text = true,
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
