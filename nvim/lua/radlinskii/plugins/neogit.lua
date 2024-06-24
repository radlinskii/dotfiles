return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration
        "folke/which-key.nvim",

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
    },
    keys = { "<leader>g", desc = "Neogit" },
    init = function()
        local wk = require("which-key")

        wk.register({
            ["<leader>g"] = {
                name = "Neogit",
            },
        })
    end,
    config = function()
        local neogit = require("neogit")
        -- TODO:
        -- 1. zo/zc not working in status before "Toggle" isn't called at least once
        -- 2. refresh git_signs after staging/unstaging files
        -- 3. be able to delete branch with -D option
        -- 4. telescope config is somehow used when getting lists of e.g. branches "unsupported layout_config config for bottom_pane strategy flip_columns"
        -- 5. floating windows breaking
        -- 6. not being able to remove a mapping is weird, at least error message should say this

        neogit.setup({
            filewatcher = {
                interval = 1000,
                enabled = true,
            },
            auto_refresh = true,
            kind = "auto",
            commit_editor = {
                kind = "tab",
            },
            -- commit_select_view = {
            --     kind = "tab",
            -- },
            -- commit_view = {
            --     kind = "vsplit",
            --     verify_commit = vim.fn.executable("gpg") == 1,
            -- },
            -- log_view = {
            --     kind = "tab",
            -- },
            -- rebase_editor = {
            --     kind = "auto",
            -- },
            -- reflog_view = {
            --     kind = "tab",
            -- },
            -- merge_editor = {
            --     kind = "auto",
            -- },
            -- description_editor = {
            --     kind = "auto",
            -- },
            -- tag_editor = {
            --     kind = "auto",
            -- },
            -- preview_buffer = {
            --     kind = "split",
            -- },
            -- popup = {
            --     kind = "split",
            -- },
            -- refs_view = {
            --     kind = "tab",
            -- },
            mappings = {
                status = {
                    ["U"] = false,
                    ["k"] = false,
                    ["u"] = "MoveUp",
                    ["j"] = false,
                    ["e"] = "MoveDown",
                    ["h"] = "Unstage",
                    ["H"] = "UnstageStaged",
                    ["<c-v>"] = false,
                    ["<c-y>"] = "VSplitOpen",
                },
            },
        })

        -- vim.keymap.set("n", "<leader>g", function()
        --     local instance = require("neogit.buffers.status").instance()
        --
        --     if instance then
        --         neogit.close()
        --     else
        --         neogit.open()
        --     end
        -- end, { desc = "Toggle neogit", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>g", function()
            neogit.open()
        end, { desc = "Toggle neogit", noremap = true, silent = true })
    end,
}
