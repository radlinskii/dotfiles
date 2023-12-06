return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_session_suppress_dirs = {
                "/",
                "~/",
                "~/Downloads",
                "~/Documents",
                "~/Desktop/",
                "~/Projects/",
                "~/Library/",
            },
            session_lens = {
                buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
            },
            pre_save_cmds = {
                "lua require('radlinskii.utils.window').close_all_floating_wins()",
                "lua require('radlinskii.utils.window').close_all_nvim_tree_buffers()",
            },
        })

        local keymap = vim.keymap

        keymap.set(
            "n",
            "<leader>wr",
            "<cmd>SessionRestore<CR>",
            { desc = "Restore session for cwd", noremap = true, silent = true }
        ) -- restore last workspace session for current directory
        keymap.set(
            "n",
            "<leader>ws",
            "<cmd>SessionSave<CR>",
            { desc = "Save session for auto session root dir", noremap = true, silent = true }
        ) -- save workspace session for current working directory

        vim.keymap.set("n", "<leader>fw", require("auto-session.session-lens").search_session, {
            desc = "Find saved vim session",
            noremap = true,
            silent = true,
        })
    end,
}
