---@type LazyPluginSpec
return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    keys = {
        {
            "<C-p>",
            "<cmd> FzfLua buffers <CR>",
            mode = { "n" },
            desc = "Find buffers",
        },
        {
            "<C-n>",
            "<cmd> FzfLua buffers <CR>",
            desc = "Find buffers",
            mode = { "n" },
        },
        {
            "<leader>fb",
            "<cmd> FzfLua buffers <CR>",
            desc = "Find buffers",
        },
        {
            "<leader>ff",
            "<cmd> FzfLua files <CR>",
            desc = "Find files, including hidden files, excluding ignored",
        },
        {
            "<leader>fF",
            "<cmd>lua require'fzf-lua'.files({ fd_opts = '--hidden --no-ignore', rg_opts = '--hidden --no-ignore' })<CR>",
            desc = "Find all files including hidden and ignored",
        },
        {
            "<leader>fo",
            "<cmd>lua require('fzf-lua').oldfiles({ cwd_only = true }) <CR>",
            desc = "Find oldfiles from CWD",
        },
        {
            "<leader>fO",
            "<cmd> FzfLua oldfiles <CR>",
            desc = "Find global nvim oldfiles",
        },
        {
            "<leader>fc",
            "<cmd> FzfLua grep_cword <CR>",
            desc = "Find string under cursor in cwd with args",
        },
        {
            "<leader>fC",
            "<cmd>FzfLua grep_last<cr>",
            desc = "Continue last grep search",
        },
        {
            "<leader>fs",
            "<cmd> FzfLua grep <CR>",
            desc = "Grep",
        },
        {
            "<leader>fS",
            "<cmd> FzfLua live_grep <CR>",
            desc = "Live grep",
        },
        {
            "<leader>fz",
            "<cmd> FzfLua lgrep_curbuf<CR>",
            desc = "Grep in current buffer",
        },
        {
            "<leader>f.",
            "<cmd> FzfLua resume <CR>",
            desc = "Resume last search",
        },
        {
            "<leader>fh",
            "<cmd> FzfLua help_tags <CR>",
            desc = "Find help pages",
        },
        {
            "<leader>fD",
            "<cmd> FzfLua diagnostics_document <CR>",
            desc = "Find diagnostics in whole project",
        },
        {
            "<leader>fd",
            "<cmd> FzfLua diagnostics_workspace <CR>",
            desc = "Find diagnostics in whole project",
        },
        {
            "<leader>fj",
            "<cmd> FzfLua jumps <CR>",
            desc = "Find items in jumplist",
        },
        {
            "<leader>fm",
            "<cmd> FzfLua marks <CR>",
            desc = "Find items in bookmarks",
        },
        {
            "<leader>fgc",
            "<cmd> FzfLua git_bcommits <CR>",
            desc = "Git commits history of current buffer",
        },
        {
            "<leader>fgc",
            "<cmd> FzfLua git_commits <CR>",
            desc = "Git commits history",
        },
        {
            "<leader>fgs",
            "<cmd> FzfLua git_status <CR>",
            desc = "Git status",
        },
        {
            "<leader>fgb",
            "<cmd> FzfLua git_branches <CR>",
            desc = "Git branches",
        },
        {
            "<leader>fgz",
            "<cmd> FzfLua git_stash <CR>",
            desc = "Git stashes",
        },
        {
            "<leader>fq",
            "<cmd> FzfLua quickfix <CR>",
            desc = "Find items in quickfix list",
        },
        {
            "<leader>fl",
            "<cmd> FzfLua loclist <CR>",
            desc = "Find items in loclist",
        },
        {
            "<leader>fc",
            "<cmd> FzfLua grep_visual <CR>",
            desc = "Find selected string",
            mode = { "x" },
        },
    },
    config = function()
        local actions = require("fzf-lua.actions")
        local fzf_lua = require("fzf-lua")

        fzf_lua.setup({
            winopts = {
                width = 0.95,
                height = 0.93,
                row = 0.50,
            },
            actions = {
                files = {
                    ["enter"] = actions.file_edit,
                    ["ctrl-h"] = actions.file_split,
                    ["ctrl-v"] = actions.file_vsplit,
                },
            },
            grep = {
                rg_glob = true,
                glob_separator = "%s%-%-%s", -- query separator pattern (lua): ' -- '
            },
            buffers = {
                formatter = "path.filename_first",
                actions = {
                    -- actions inherit from 'actions.files' and merge
                    -- by supplying a table of functions we're telling
                    -- fzf-lua to not close the fzf window, this way we
                    -- can resume the buffers picker on the same window
                    -- eliminating an otherwise unaesthetic win "flash"
                    ["ctrl-d"] = { fn = actions.buf_del, reload = true },
                },
            },
            oldfiles = {
                formatter = "path.filename_first",
            },
        })
    end,
}
