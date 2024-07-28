---@type LazyPluginSpec
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    keys = {
        {
            "<C-p>",
            "<cmd> Telescope buffers <CR>",
            mode = { "n" },
            desc = "Telescope buffers",
        },
        {
            "<C-n>",
            "<cmd> Telescope buffers <CR>",
            desc = "Telescope buffers",
            mode = { "n" },
        },
        {
            "<leader>fc",
            "<cmd> lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor() <CR>",
            desc = "Find string under cursor in cwd with args",
        },
        {
            "<leader>fC",
            "<cmd>Telescope grep_string<cr>",
            desc = "Find string under cursor in cwd",
        },
        {
            "<leader>fa",
            "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
            desc = "Find all",
        },
        {
            "<leader>fh",
            "<cmd> Telescope help_tags <CR>",
            desc = "Help page",
        },
        {
            "<leader>fz",
            "<cmd> Telescope current_buffer_fuzzy_find <CR>",
            desc = "Find in current buffer",
        },
        {
            "<leader>fs",
            "<cmd> Telescope live_grep_args <CR>",
            desc = "Live grep with args",
        },
        {
            "<leader>fS",
            "<cmd> Telescope live_grep <CR>",
            desc = "Live grep",
        },
        {
            "<leader>ff",
            "<cmd> lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--follow', '-g', '!.git/**', '--hidden' }}) <CR>",
            desc = "Find files, including hidden files, but those in .git folder",
        },
        {
            "<leader>fo",
            "<cmd> lua require('telescope.builtin').oldfiles({cwd_only = true}) <CR>",
            desc = "Find oldfiles from CWD",
        },
        {
            "<leader>fO",
            "<cmd> lua require('telescope.builtin').oldfiles({cwd_only = false}) <CR>",
            desc = "Find global vim oldfiles",
        },
        {
            "<leader>fr",
            "<cmd> Telescope lsp_references <CR>",
            desc = "Find LSP references",
        },
        {
            "<leader>fp",
            "<cmd> Telescope diagnostics <CR>",
            desc = "Open telescope diagnostics",
        },
        {
            "<leader>fj",
            "<cmd> Telescope jumplist <CR>",
            desc = "Telescope jumplist",
        },
        {
            "<leader>fm",
            "<cmd> Telescope marks <CR>",
            desc = "Telescope bookmarks",
        },
        {
            "<leader>fgc",
            "<cmd> Telescope git_commits <CR>",
            desc = "Git commits",
        },
        {
            "<leader>fgs",
            "<cmd> Telescope git_status <CR>",
            desc = "Git status",
        },
        {
            "<leader>fgb",
            "<cmd> Telescope git_branches <CR>",
            desc = "Git branches",
        },
        {
            "<leader>fgz",
            "<cmd> Telescope git_stash <CR>",
            desc = "Git stashes",
        },
        {
            "<leader>fb",
            "<cmd> Telescope buffers <CR>",
            desc = "Telescope buffers",
        },
        {
            "<leader>fc",
            "<cmd> lua require('telescope-live-grep-args.shortcuts').grep_visual_selection() <CR>",
            desc = "Find selected string with args",
            mode = { "x" },
        },
    },
    cmd = { "Telescope" },
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
                        ["<C-e>"] = actions.cycle_history_next,
                        ["<C-y>"] = actions.cycle_history_prev,
                        ["<C-b>"] = actions.preview_scrolling_up,
                        ["<C-f>"] = actions.preview_scrolling_down,
                        ["<C-u>"] = false,

                        ["<C-/>"] = actions.select_vertical,
                        ["<C-_>"] = actions.select_vertical,

                        -- buffers
                        ["<C-d>"] = actions.delete_buffer,

                        -- live grep args
                        ["<C-k>"] = lga_actions.quote_prompt(), -- "kuote"
                        ["<C-j>"] = lga_actions.quote_prompt({ postfix = " --iglob " }), -- "jlob"
                        -- freeze the current list and start a fuzzy search in the frozen list
                        ["<C-l>"] = actions.to_fuzzy_refine, -- "lock" and refine

                        ["<C-o>?"] = actions.which_key,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<C-c>"] = actions.close,
                        ["<C-e>"] = actions.cycle_history_next,
                        ["<C-y>"] = actions.cycle_history_prev,
                        ["<C-b>"] = actions.preview_scrolling_up,
                        ["<C-f>"] = actions.preview_scrolling_down,

                        ["<C-/>"] = actions.select_vertical,
                        ["<C-_>"] = actions.select_vertical,

                        ["e"] = actions.move_selection_next,
                        ["u"] = actions.move_selection_previous,
                        ["N"] = actions.move_to_top,
                        ["M"] = actions.move_to_middle,
                        ["I"] = actions.move_to_bottom,
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,

                        -- buffers
                        ["<C-d>"] = actions.delete_buffer,

                        -- live grep args
                        ["<C-k>"] = lga_actions.quote_prompt(), -- "kuote"
                        ["<C-j>"] = lga_actions.quote_prompt({ postfix = " --iglob " }), -- jglob
                        -- freeze the current list and start a fuzzy search in the frozen list
                        ["<C-l>"] = actions.to_fuzzy_refine, -- "lock" and refine
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
    end,
}
