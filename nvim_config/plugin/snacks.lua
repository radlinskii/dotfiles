vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
    animate = {
        enabled = true,
    },
    bigfile = {
        enabled = true,
        notify = true,
        size = 1.5 * 1024 * 1024,
        line_length = 1000,
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
})

local prev = { new_name = "", old_name = "" }
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

vim.keymap.set({ "n", "v" }, "<leader>gB", function()
    Snacks.gitbrowse()
end, { desc = "Git Browse" })

vim.keymap.set({ "n", "v" }, "<leader>gb", function()
    Snacks.git.blame_line()
end, { desc = "Git blame line" })

vim.keymap.set("n", "<leader>rF", function()
    Snacks.rename.rename_file()
end, { desc = "Rename File" })

vim.keymap.set({ "n", "t" }, "]]", function()
    Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })

vim.keymap.set({ "n", "t" }, "[[", function()
    Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

vim.keymap.set("n", "<leader>fn", function()
    Snacks.notifier.show_history()
end, { desc = "Notification History" })
