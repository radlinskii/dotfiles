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
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
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
                "vimdoc",
                "dockerfile",
                "gitignore",
                "go",
                "astro",
            },
            -- use flash.nvim treesitter mode instead
            -- incremental_selection = {
            --     enable = true,
            --     }
            matchup = { enable = true },
        })
    end,
}
