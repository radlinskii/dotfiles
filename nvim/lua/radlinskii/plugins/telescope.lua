return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

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
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
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
                        ["<Tab>"] = actions.move_selection_next,
                        ["<S-Tab>"] = actions.move_selection_previous,
                        ["<C-n>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<C-p>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-h>"] = actions.select_horizontal,
                        ["<C-g>"] = actions.complete_tag,
                    },
                    n = {
                        ["q"] = require("telescope.actions").close,
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

                extensions_list = { "themes", "terms", "fzf" },
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
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

        keymap.set(
            { "n" },
            "<leader>fa",
            "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
            { silent = true, noremap = true, desc = "Find all" }
        )
        keymap.set(
            { "n" },
            "<leader>fh",
            "<cmd> Telescope help_tags <CR>",
            { silent = true, noremap = true, desc = "Help page" }
        )
        keymap.set(
            { "n" },
            "<leader>fz",
            "<cmd> Telescope current_buffer_fuzzy_find <CR>",
            { silent = true, noremap = true, desc = "Find in current buffer" }
        )
        keymap.set(
            { "n" },
            "<leader>fs",
            "<cmd> Telescope live_grep <CR>",
            { silent = true, noremap = true, desc = "Live grep" }
        )

        keymap.set(
            { "n" },
            "<leader>ff",
            "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '--follow', '-g', '!.git' }})<CR>",
            { desc = "Find files, including hidden files, but those in .git folder", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>fo",
            "<cmd> lua require('telescope.builtin').oldfiles({cwd_only = true}) <CR>",
            { desc = "Find oldfiles from CWD", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>fO",
            "<cmd> lua require('telescope.builtin').oldfiles({cwd_only = false}) <CR>",
            { desc = "Find global vim oldfiles", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>fr",
            "<cmd> Telescope lsp_references <CR>",
            { desc = "Find LSP references", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>fp",
            "<cmd> Telescope diagnostics <CR>",
            { desc = "Open telescope diagnostics", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>fm",
            "<cmd> Telescope marks <CR>",
            { desc = "Telescope bookmarks", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>fgc",
            "<cmd> Telescope git_commits <CR>",
            { desc = "Git commits", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>fgs",
            "<cmd> Telescope git_status <CR>",
            { desc = "Git status", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>fgb",
            "<cmd> Telescope git_branches <CR>",
            { desc = "Git branches", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>fgz",
            "<cmd> Telescope git_stash <CR>",
            { desc = "Git stashes", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<leader>ft",
            "<cmd> Telescope terms <CR>",
            { desc = "Pick hidden term", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<Tab>",
            "<cmd> Telescope buffers <CR>",
            { desc = "Telescope buffers", silent = true, noremap = true }
        )
        keymap.set(
            { "n" },
            "<S-Tab>",
            "<cmd> Telescope buffers <CR>",
            { desc = "Telescope buffers", silent = true, noremap = true }
        )
    end,
}