-- TODO: add <C-o>h and <C-o>v mappings

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/which-key.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    keys = { { "<leader>f", desc = "Telescope" } },
    cmd = { "Telescope" },
    init = function()
        local wk = require("which-key")

        wk.register({
            ["<leader>fg"] = {
                name = "Telescope Git",
            },
        })

        vim.keymap.set(
            { "n" },
            "<C-p>",
            "<cmd> Telescope buffers <CR>",
            { desc = "Telescope buffers", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<C-n>",
            "<cmd> Telescope buffers <CR>",
            { desc = "Telescope buffers", silent = true, noremap = true }
        )
    end,
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local lga_actions = require("telescope-live-grep-args.actions")

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    -- "--sort=path",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "flex",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        mirror = false,
                    },
                    vertical = {
                        prompt_position = "top",
                        mirror = true,
                    },
                    flip_lines = 60,
                    flip_columns = 140,
                },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "node_modules" },
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                path_display = { "truncate" },
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                mappings = {
                    i = {
                        ["<C-l>"] = actions.cycle_history_next,
                        ["<C-y>"] = actions.cycle_history_prev,
                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        ["<C-h>"] = actions.select_horizontal,
                        -- TODO: this needs to change because in insert mode c-o is useful
                        -- ["<C-o>h"] = actions.select_horizontal,
                        -- ["<C-o>v"] = actions.select_vertical,
                        ["<C-x>"] = require("telescope.actions").delete_buffer,
                        ["<C-t>"] = actions.complete_tag,
                        -- live grep args
                        ["<C-k>"] = lga_actions.quote_prompt(),
                        ["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                        -- freeze the current list and start a fuzzy search in the frozen list
                        ["<C-f>"] = actions.to_fuzzy_refine,
                    },
                    n = {
                        ["q"] = require("telescope.actions").close,
                        ["<C-l>"] = actions.cycle_history_next,
                        ["<C-y>"] = actions.cycle_history_prev,
                        ["<C-h>"] = actions.select_horizontal,
                        -- TODO: this needs to change because in insert mode c-o is useful
                        -- ["<C-o>h"] = actions.select_horizontal,
                        -- ["<C-o>v"] = actions.select_vertical,
                        ["<C-x>"] = require("telescope.actions").delete_buffer,
                        ["e"] = actions.move_selection_next,
                        ["u"] = actions.move_selection_previous,
                        ["N"] = actions.move_to_top,
                        ["M"] = actions.move_to_middle,
                        ["I"] = actions.move_to_bottom,
                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                    },
                },

                extensions_list = { "themes", "terms", "fzf", "live_grep_args" },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            },
            pickers = {
                buffers = {
                    sort_lastused = true,
                    sort_mru = true,
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")

        vim.keymap.set(
            { "n" },
            "<leader>fc",
            "<cmd> lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor() <CR>",
            { desc = "Find string under cursor in cwd with args", silent = true, noremap = true }
        )
        vim.keymap.set(
            "n",
            "<leader>fC",
            "<cmd>Telescope grep_string<cr>",
            { desc = "Find string under cursor in cwd" }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fa",
            "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
            { silent = true, noremap = true, desc = "Find all" }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fh",
            "<cmd> Telescope help_tags <CR>",
            { silent = true, noremap = true, desc = "Help page" }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fz",
            "<cmd> Telescope current_buffer_fuzzy_find <CR>",
            { silent = true, noremap = true, desc = "Find in current buffer" }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fs",
            "<cmd> Telescope live_grep_args <CR>",
            { silent = true, noremap = true, desc = "Live grep with args" }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fS",
            "<cmd> Telescope live_grep <CR>",
            { silent = true, noremap = true, desc = "Live grep" }
        )
        vim.keymap.set(
            { "n" },
            "<leader>ff",
            "<cmd> lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--follow', '-g', '!.git/**', '--hidden' }}) <CR>",
            { desc = "Find files, including hidden files, but those in .git folder", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fo",
            "<cmd> lua require('telescope.builtin').oldfiles({cwd_only = true}) <CR>",
            { desc = "Find oldfiles from CWD", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fO",
            "<cmd> lua require('telescope.builtin').oldfiles({cwd_only = false}) <CR>",
            { desc = "Find global vim oldfiles", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fr",
            "<cmd> Telescope lsp_references <CR>",
            { desc = "Find LSP references", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fp",
            "<cmd> Telescope diagnostics <CR>",
            { desc = "Open telescope diagnostics", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fm",
            "<cmd> Telescope marks <CR>",
            { desc = "Telescope bookmarks", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fgc",
            "<cmd> Telescope git_commits <CR>",
            { desc = "Git commits", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fgs",
            "<cmd> Telescope git_status <CR>",
            { desc = "Git status", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fgb",
            "<cmd> Telescope git_branches <CR>",
            { desc = "Git branches", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fgz",
            "<cmd> Telescope git_stash <CR>",
            { desc = "Git stashes", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fH",
            -- TODO: wtf is hidden term?
            "<cmd> Telescope terms <CR>",
            { desc = "Pick hidden term", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "n" },
            "<leader>fb",
            "<cmd> Telescope buffers <CR>",
            { desc = "Telescope buffers", silent = true, noremap = true }
        )
        vim.keymap.set(
            { "x" },
            "<leader>fc",
            "<cmd> lua require('telescope-live-grep-args.shortcuts').grep_visual_selection() <CR>",
            { desc = "Find selected string with args", silent = true, noremap = true }
        )
    end,
}
