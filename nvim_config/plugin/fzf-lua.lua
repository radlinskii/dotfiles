vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/s1n7ax/nvim-window-picker" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
})

vim.keymap.set("n", "<leader>fa", "<cmd>FzfLua<CR>", { desc = "FzfLua" })
vim.keymap.set("n", "<C-p>", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<C-n>", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files, including hidden files, excluding ignored" })
vim.keymap.set("n", "<leader>fF", "<cmd>lua require'fzf-lua'.files({ fd_opts = '--hidden --no-ignore', rg_opts = '--hidden --no-ignore' })<CR>", { desc = "Find all files including hidden and ignored" })
vim.keymap.set("n", "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles({ cwd_only = true })<CR>", { desc = "Find oldfiles from CWD" })
vim.keymap.set("n", "<leader>fO", "<cmd>FzfLua oldfiles<CR>", { desc = "Find global nvim oldfiles" })
vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua grep_cword<CR>", { desc = "Find string under [c]ursor in cwd with args" })
vim.keymap.set("n", "<leader>fC", "<cmd>FzfLua grep_last<cr>", { desc = "[C]ontinue last grep search" })
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua grep<CR>", { desc = "Grep [w]ords" })
vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep [s]earch" })
vim.keymap.set("n", "<leader>fS", "<cmd>FzfLua live_grep_resume<CR>", { desc = "Continue last grep [S]earch as live grep" })
vim.keymap.set("n", "<leader>fz", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "Grep in current buffer" })
vim.keymap.set("n", "<leader>f.", "<cmd>FzfLua resume<CR>", { desc = "Resume last search" })
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "Find help pages" })
vim.keymap.set("n", "<leader>fD", "<cmd>FzfLua diagnostics_document<CR>", { desc = "Find diagnostics in whole project" })
vim.keymap.set("n", "<leader>fd", "<cmd>FzfLua diagnostics_workspace<CR>", { desc = "Find diagnostics in whole project" })
vim.keymap.set("n", "<leader>fj", "<cmd>FzfLua jumps<CR>", { desc = "Find items in jumplist" })
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "Find items in bookmarks" })
vim.keymap.set("n", "<leader>fgc", "<cmd>FzfLua git_bcommits<CR>", { desc = "Git commits history of current buffer" })
vim.keymap.set("n", "<leader>fgc", "<cmd>FzfLua git_commits<CR>", { desc = "Git commits history" })
vim.keymap.set("n", "<leader>fgs", "<cmd>FzfLua git_status<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>fgb", "<cmd>FzfLua git_branches<CR>", { desc = "Git branches" })
vim.keymap.set("n", "<leader>fgz", "<cmd>FzfLua git_stash<CR>", { desc = "Git stashes" })
vim.keymap.set("n", "<leader>fq", "<cmd>FzfLua quickfix<CR>", { desc = "Find items in quickfix list" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua registers<CR>", { desc = "Search stuff in registers" })
vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua loclist<CR>", { desc = "Find items in loclist" })
vim.keymap.set("x", "<leader>fc", "<cmd>FzfLua grep_visual<CR>", { desc = "Find selected string" })

local actions = require("fzf-lua.actions")
local fzf_lua = require("fzf-lua")

local file_edit_with_window_picker = function(selected, opts)
    local fallback = vim.api.nvim_get_current_win()
    local window_id = require("window-picker").pick_window() or fallback

    vim.api.nvim_set_current_win(window_id)
    require("fzf-lua.actions").file_edit(selected, opts)
end

fzf_lua.setup({
    winopts = {
        width = 0.95,
        height = 0.93,
        row = 0.50,
    },
    actions = {
        files = {
            ["enter"] = actions.file_edit,
            ["ctrl-o"] = file_edit_with_window_picker,
            ["ctrl-h"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
        },
    },
    previewers = {
        bat = {
            theme = "ansi",
        },
    },
    grep = {
        rg_glob = true,
        glob_separator = "%s%-%-%s",
        hidden = true,
    },
    defaults = {
        formatter = { "path.filename_first", 2 },
    },
    buffers = {
        previewer = false,
        actions = {
            ["ctrl-d"] = { fn = actions.buf_del, reload = true },
        },
    },
})

fzf_lua.register_ui_select(function(_, items)
    local min_h, max_h = 0.15, 0.70
    local h = (#items + 4) / vim.o.lines
    if h < min_h then
        h = min_h
    elseif h > max_h then
        h = max_h
    end

    return { winopts = { height = h, width = 0.60, row = 0.40 } }
end)
