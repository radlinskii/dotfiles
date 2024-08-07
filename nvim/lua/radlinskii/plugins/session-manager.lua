---@type LazyPluginSpec[]
return {
    {
        "rmagatti/auto-session",
        lazy = false,
        enabled = true,
        dependencies = {
            "nvim-telescope/telescope.nvim",
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
                -- issue on windows with "-" in git branch name turns into "\\" in file name
                -- auto_session_use_git_branch = true,
            })

            -- use Autosession search for switching
            -- and Autosession delete for deleting sessions
        end,
    },
}
