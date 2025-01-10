local HEIGHT_RATIO = 0.95
local WIDTH_RATIO = 0.5

local function nvim_tree_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "gr", api.fs.rename_full, opts("Rename: Full Path"))
    vim.keymap.set("n", "R", api.fs.rename_basename, opts("Rename: Basename"))
    vim.keymap.set("n", "<C-l>", api.tree.reload, opts("Refresh"))
    vim.keymap.set("n", "gs", api.node.run.system, opts("Run system"))
    vim.keymap.set("n", "<c-v>", api.node.open.vertical, opts("Split vertical"))
    vim.keymap.set("n", "<c-h>", api.node.open.horizontal, opts("Split vertical"))
    vim.keymap.set("n", "<c-c>", api.tree.close, opts("Close"))
    vim.keymap.set("n", "<right>", api.node.open.no_window_picker, opts("Open: No window picker"))
    vim.keymap.set("n", "o", api.node.open.no_window_picker, opts("Open: No window picker"))
    vim.keymap.set("n", "O", api.node.open.edit, opts("Open: with picker"))
    vim.keymap.set("n", "<left>", api.node.navigate.parent_close, opts("Close parent directory"))

    vim.keymap.del("n", "q", { buffer = bufnr })
    vim.keymap.del("n", "s", { buffer = bufnr })
    vim.keymap.del("n", "e", { buffer = bufnr })
    vim.keymap.del("n", "u", { buffer = bufnr })
end

---@type LazyPluginSpec
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
        { "<leader>ef", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
        { "<leader>ec", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" },
        { "<leader>ex", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" },
        { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
    },

    config = function()
        local nvimtree = require("nvim-tree")

        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- change color for arrows in tree to light blue
        vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
        vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])
        vim.cmd([[ highlight NvimTreeWindowPicker guifg=#009944 guibg=#990079 ]])

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
                float = {
                    enable = true,
                    open_win_config = function()
                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = screen_w * WIDTH_RATIO
                        local window_h = screen_h * HEIGHT_RATIO
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w) / 2
                        -- local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

                        return {
                            border = "rounded",
                            relative = "editor",
                            row = 0,
                            col = center_x,
                            width = window_w_int,
                            height = window_h_int,
                        }
                    end,
                },
                width = function()
                    return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                end,
                relativenumber = false,
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = true,
                        chars = "TSRADCXZPFWQ0123456789",
                    },
                },
                expand_all = {
                    exclude = { ".git", "node_modules" },
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
    end,
}
