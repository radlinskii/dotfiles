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

            -- TODO: telescope errors because of flip_columns config
            vim.keymap.set("n", "<leader>fA", require("auto-session.session-lens").search_session, {
                noremap = true,
                silent = true,
                desc = "List AutoSession records",
            })
        end,
    },
}
