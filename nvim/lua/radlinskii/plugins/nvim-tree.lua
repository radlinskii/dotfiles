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
    vim.keymap.set("n", "<c-/>", api.node.open.vertical, opts("Split vertical"))
    vim.keymap.set("n", "<c-_>", api.node.open.vertical, opts("Split vertical"))

    vim.keymap.del("n", "s", { buffer = bufnr })
end

---@type LazyPluginSpec
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/which-key.nvim" },
    keys = { { "<leader>e" } },
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
                git_ignored = false,
                dotfiles = false,
                custom = { ".DS_Store" },
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
                side = "right",
                width = 40,
                relativenumber = false,
                preserve_window_proportions = true,
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            renderer = {
                highlight_git = "name",
                highlight_diagnostics = "name",
                highlight_opened_files = "name",
                highlight_modified = "name",
                highlight_bookmarks = "name",
                highlight_clipboard = "name",
                indent_markers = {
                    enable = true,
                },
            },
            on_attach = nvim_tree_on_attach,
        })

        local keymap = vim.keymap
        local wk = require("which-key")

        wk.register({
            ["<leader>e"] = {
                name = "Files Tree",
            },
        })

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
