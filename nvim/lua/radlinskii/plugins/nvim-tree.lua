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
    vim.keymap.set("n", "gs", api.node.run.system, opts("Run system"))
    vim.keymap.set("n", "<c-o>v", api.node.open.vertical, opts("Split vertical"))
    vim.keymap.set("n", "<c-o>h", api.node.open.horizontal, opts("Split horizontal"))

    vim.keymap.del("n", "s", { buffer = bufnr })
end

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/which-key.nvim" },
    keys = { { "<leader>e", desc = "Files Tree" } },
    init = function()
        local wk = require("which-key")

        wk.register({
            ["<leader>e"] = {
                name = "Files Tree init",
            },
        })
    end,
    config = function()
        local nvimtree = require("nvim-tree")

        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- change color for arrows in tree to light blue
        vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
        vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

        -- configure nvim-tree
        nvimtree.setup({
            filters = {
                dotfiles = false,
                custom = { ".DS_Store" },
                exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
            },
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                adaptive_size = false,
                side = "right",
                width = 35,
                relativenumber = true,
                preserve_window_proportions = true,
            },
            git = {
                enable = false,
                ignore = true,
            },
            filesystem_watchers = {
                enable = true,
            },
            actions = {
                open_file = {
                    resize_window = true,
                    window_picker = {
                        enable = false, -- test
                    },
                },
            },
            renderer = {
                root_folder_label = false,
                highlight_git = true,
                highlight_opened_files = "none",

                indent_markers = {
                    enable = true,
                },

                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },

                    glyphs = {
                        default = "󰈚",
                        symlink = "",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                            symlink_open = "",
                            arrow_open = "",
                            arrow_closed = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },
            on_attach = nvim_tree_on_attach,
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })
        keymap.set(
            "n",
            "<leader>ec",
            "<cmd>NvimTreeFindFileToggle<CR>",
            { desc = "Toggle file explorer on current file" }
        )
        keymap.set("n", "<leader>ex", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
    end,
}
