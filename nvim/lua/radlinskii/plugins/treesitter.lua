---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy", "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        -- "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({ -- enable syntax highlighting
            highlight = {
                enable = true,
                use_languagetree = true,
            },
            -- enable indentation
            indent = { enable = true },
            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = {
                enable = true,
            },
            -- ensure these language parsers are installed
            ensure_installed = {
                "json",
                "json5",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "css",
                "markdown",
                "markdown_inline",
                "bash",
                "lua",
                "vim",
                "dockerfile",
                "gitignore",
            },
            -- incremental_selection = {
            --     enable = true,
            --     keymaps = {
            --         init_selection = "<leader>v",
            --         node_incremental = "<leader>v",
            --         scope_incremental = true,
            --         node_decremental = "<bs>",
            --     },
            -- },
            matchup = { enable = true },
            -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        })
    end,
}
