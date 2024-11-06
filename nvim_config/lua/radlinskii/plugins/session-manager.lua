---@type LazyPluginSpec[]
return {
    {
        "rmagatti/auto-session",
        lazy = false,
        enabled = true,
        dependencies = { "nvim-telescope/telescope.nvim" },
        keys = {
            {
                "<leader>SS",
                "<cmd>SessionSave<CR>",
                desc = "Save current session",
            },
            {
                "<leader>SR",
                "<cmd>SessionRestore<CR>",
                desc = "Restore current session",
            },
        },
        config = function()
            require("auto-session").setup({
                auto_session_suppress_dirs = {
                    "/",
                    "~",
                    "~/",
                    "/tmp",
                    "~/Downloads",
                    "~/Documents",
                    "~/Desktop",
                    "~/Projects",
                    "~/Library",
                },
                auto_save = false,
                auto_create = true,
                auto_restore = false,
                -- issue on windows with "-" in git branch name turns into "\\" in file name
                -- auto_session_use_git_branch = true,
            })

            -- use Autosession search for switching
            -- and Autosession delete for deleting sessions
        end,
    },
}
