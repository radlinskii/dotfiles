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

    matchup = { enable = true },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}

local actions = require("telescope.actions")
M.telescope = {
    defaults = {
        mappings = {
            i = {
                ["<C-l>"] = actions.cycle_history_next,
                ["<C-y>"] = actions.cycle_history_prev,
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
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
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
            },
        },
    },
    pickers = {
        buffers = {
            sort_lastused = true,
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

local function nvim_tree_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "J", api.tree.expand_all, opts("Expand All"))
    vim.keymap.set("n", "j", api.fs.rename_basename, opts("Rename: Basename"))
    vim.keymap.set("n", "K", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
    vim.keymap.set("n", "E", api.node.navigate.sibling.last, opts("Last Sibling"))
    vim.keymap.set("n", "U", api.node.navigate.sibling.first, opts("First Sibling"))
    vim.keymap.set("n", "u", "k", opts("Prev item"))
    vim.keymap.set("n", "e", "j", opts("Next item"))
end

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
    on_attach = nvim_tree_on_attach,
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
