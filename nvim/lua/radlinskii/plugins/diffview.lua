---@type LazyPluginSpec
return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggle", "DiffviewFileHistory" },
    keys = {
        {
            "<leader>dc",
            "<cmd>DiffviewClose<CR>",
            desc = "Close Diffview",
        },
        {
            "<leader>do",
            "<cmd>DiffviewOpen<CR>",
            desc = "Open Diffview",
        },
        {
            "<leader>dh",
            "<cmd>DiffviewFileHistory %<CR>",
            desc = "Open file history Diffview",
        },
    },
    opts = {
        hooks = {
            diff_view_opened = function()
                vim.cmd("ColorizerDetachFromBuffer")
            end,
            diff_view_closed = function()
                vim.cmd("ColorizerAttachToBuffer")
                vim.cmd("ColorizerReloadAllBuffers")
            end,
        },
    },
}
