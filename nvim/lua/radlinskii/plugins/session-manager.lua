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
                -- log_level = "debug",
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
                auto_session_use_git_branch = true,
            })

            --TODO:
            -- local file_content = vim.fn.readfile(session_control_file)
            -- local content = table.concat(file_content, " ")
            -- in auto-session/init.lua:632

            -- use Autosession search for switching
            -- and Autosettion delete for deleting sessions
        end,
    },
}
