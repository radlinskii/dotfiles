---@type LazyPluginSpec[]
return {
    { enabled = true, "meznaric/key-analyzer.nvim", opts = {}, cmd = "KeyAnalyzer" },
    { enabled = false, "tpope/vim-sleuth", lazy = false },
    {
        enabled = false,
        "j-morano/buffer_manager.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            {
                -- clashes with snipe.nvim
                "<leader>bm",
                function()
                    require("buffer_manager.ui").toggle_quick_menu()
                    -- wait for the menu to open
                    vim.defer_fn(function()
                        vim.fn.feedkeys("$")
                    end, 50)
                end,
                desc = "Toggle buffer list",
            },
        },
        config = function()
            require("buffer_manager").setup({
                height = 0.6,
                select_menu_item_commands = {
                    v = {
                        key = "<C-v>",
                        command = "vsplit",
                    },
                    h = {
                        key = "<C-h>",
                        command = "split",
                    },
                },
                focus_alternate_buffer = true,
                short_file_names = true,
                short_term_names = true,
                order_buffers = "lastused",
                loop_nav = true,
            })

            local opts = { noremap = true, silent = true }
            -- local map = vim.keymap.set
            local autocmd = vim.api.nvim_create_autocmd

            autocmd("FileType", {
                desc = "Toggle buffer manager off",
                pattern = { "buffer_manager" },
                callback = function()
                    vim.api.nvim_buf_set_keymap(
                        0,
                        "n",
                        "<C-c>",
                        "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<CR>",
                        opts
                    )
                end,
            })

            -- Navigate buffers bypassing the menu
            -- local keys = "1234567890"
            -- for i = 1, #keys do
            --     local key = keys:sub(i, i)
            --     map("n", string.format("<leader>%s", key), function()
            --         bmui.nav_file(i)
            --     end, opts)
            -- end

            -- Next/Prev
            -- map("n", "<C-n>", bmui.nav_next, opts)
            -- map("n", "<C-p>", bmui.nav_prev, opts)
        end,
    },
}
