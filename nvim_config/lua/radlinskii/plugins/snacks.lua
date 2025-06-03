---@type LazyPluginSpec
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
            mode = { "n", "v" },
        },
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git blame line",
            mode = { "n", "v" },
        },
        {
            "<leader>rF",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename File",
        },
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            mode = { "n", "t" },
        },
        {
            "<leader>fn",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Notification History",
        },
    },
    ---@type snacks.Config
    opts = {
        animate = {
            enabled = true,
        },
        bigfile = {
            enabled = true,
            notify = true, -- show notification when big file detected
            size = 1.5 * 1024 * 1024, -- 1.5MB
            line_length = 1000, -- average line length (useful for minified files)
        },
        gitbrowse = {
            enabled = true,
            what = "file",
        },
        notifier = {
            enabled = true,
        },
        words = {
            enabled = true,
        },
        indent = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        lazygit = { enabled = false },
        input = { enabled = false },
    },
    init = function()
        local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
        vim.api.nvim_create_autocmd("User", {
            pattern = "NvimTreeSetup",
            callback = function()
                local events = require("nvim-tree.api").events

                events.subscribe(events.Event.NodeRenamed, function(data)
                    if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
                        data = data
                        Snacks.rename.on_rename_file(data.old_name, data.new_name)
                    end
                end)
            end,
        })
    end,
}
