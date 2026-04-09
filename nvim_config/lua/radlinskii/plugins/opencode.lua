return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
        "ibhagwan/fzf-lua",
    },
    keys = {
        {
            "<leader>oa",
            function()
                require("opencode").ask("@this: ", { submit = true })
            end,
            mode = { "n", "x" },
            desc = "Ask opencode…",
        },
        {
            "<leader>ox",
            function()
                require("opencode").select()
            end,
            mode = { "n", "x" },
            desc = "Execute opencode action…",
        },
        {
            "<leader>ot",
            function()
                require("opencode").toggle()
            end,
            desc = "Toggle opencode",
        },
        {
            "<leader>or",
            function()
                return require("opencode").operator("@this ")
            end,
            mode = { "n", "x" },
            desc = "Add range to opencode",
            expr = true,
        },
        {
            "<leader>ol",
            function()
                return require("opencode").operator("@this ") .. "_"
            end,
            desc = "Add line to opencode",
            expr = true,
        },
        {
            "<leader>ou",
            function()
                require("opencode").command("session.half.page.up")
            end,
            desc = "Scroll opencode up",
        },
        {
            "<leader>od",
            function()
                require("opencode").command("session.half.page.down")
            end,
            desc = "Scroll opencode down",
        },
    },
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            -- Your configuration, if any; goto definition on the type or field for details
        }

        vim.o.autoread = true -- Required for `opts.events.reload`
    end,
}
