---@type LazyPluginSpec
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-frecency.nvim",
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
            "<leader>fr",
            "<cmd> Telescope frecency <CR>",
            desc = "Find file based on frecency",
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
            "<leader>f.",
            "<cmd> Telescope resume <CR>",
            desc = "Resume last search",
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
            "<leader>fq",
            "<cmd> Telescope quickfix <CR>",
            desc = "Telescope quickfix",
        },
        {
            "<leader>fl",
            "<cmd> Telescope loclist <CR>",
            desc = "Telescope loclist",
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

        local select_one_or_multi = function(prompt_bufnr)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local multi = picker:get_multi_selection()
            if not vim.tbl_isempty(multi) then
                require("telescope.actions").close(prompt_bufnr)
                for _, j in pairs(multi) do
                    if j.path ~= nil then
                        vim.cmd(string.format("%s %s", "edit", j.path))
                    end
                end
            else
                require("telescope.actions").select_default(prompt_bufnr)
            end
        end

        telescope.setup({
            defaults = {
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
                    flex = {
                        flip_lines = 60,
                        flip_columns = 140,
                    },
                },
                prompt_prefix = "   ",
                selection_caret = "> ",
                path_display = { "smart" }, -- { "truncate" },
                dynamic_preview_title = true,
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
                file_ignore_patterns = { "node_modules" },
                mappings = {
                    i = {
                        ["<C-e>"] = actions.cycle_history_next,
                        ["<C-y>"] = actions.cycle_history_prev,
                        ["<C-b>"] = actions.preview_scrolling_up,
                        ["<C-f>"] = actions.preview_scrolling_down,
                        ["<C-u>"] = false,

                        ["<C-/>"] = actions.select_vertical,
                        ["<C-_>"] = actions.select_vertical,

                        -- freeze the current list and start a fuzzy search in the frozen list
                        ["<C-l>"] = actions.to_fuzzy_refine, -- "lock" and refine

                        -- buffers
                        ["<C-d>"] = actions.delete_buffer,

                        -- live grep args
                        ["<C-k>"] = lga_actions.quote_prompt(), -- "kuote"
                        ["<C-j>"] = lga_actions.quote_prompt({ postfix = " --iglob " }), -- "jlob"

                        ["<C-o>?"] = actions.which_key,

                        ["<CR>"] = select_one_or_multi,
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

                        ["<CR>"] = select_one_or_multi,

                        -- freeze the current list and start a fuzzy search in the frozen list
                        ["<C-l>"] = actions.to_fuzzy_refine, -- "lock" and refine

                        -- buffers
                        ["<C-d>"] = actions.delete_buffer,

                        -- live grep args
                        ["<C-k>"] = lga_actions.quote_prompt(), -- "kuote"
                        ["<C-j>"] = lga_actions.quote_prompt({ postfix = " --iglob " }), -- jglob
                    },
                },
            },
            extensions_list = { "themes", "terms", "fzf", "live_grep_args", "frecency" },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                frecency = {
                    auto_validate = false,
                    matcher = "fuzzy",
                    default_workspace = "CWD",
                },
            },
            pickers = {
                buffers = {
                    sort_lastused = true,
                    sort_mru = true,
                    -- TODO: watch https://github.com/nvim-telescope/telescope.nvim/issues/3157
                    path_display = { "filename_first" },
                },
                oldfiles = {
                    -- TODO: watch https://github.com/nvim-telescope/telescope.nvim/issues/3157
                    path_display = { "filename_first" },
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")
        telescope.load_extension("frecency")
        telescope.load_extension("ui-select")
    end,
}
