---@type LazyPluginSpec[]
return {
    {
        "Shatur/neovim-session-manager",
        lazy = false,
        enabled = false,
        config = function()
            local config = require("session_manager.config")

            require("session_manager").setup({
                autoload_mode = config.AutoloadMode.CurrentDir,
                autosave_ignore_dirs = { "/", "~", "/tmp/", vim.fn.expand("~"), vim.fn.expand("~" .. "/Projects/") },
            })
        end,
    },

    {
        "stevearc/resession.nvim",
        opts = {},
        lazy = false,
        enabled = false,
        config = function()
            local resession = require("resession")

            resession.setup()

            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    -- Only load the session if nvim was started with no args
                    if vim.fn.argc(-1) == 0 then
                        -- Save these to a different directory, so our manual sessions don't get polluted
                        resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
                    end
                end,
                nested = true,
            })

            vim.api.nvim_create_autocmd("VimLeavePre", {
                callback = function()
                    resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
                end,
            })
        end,
    },

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
