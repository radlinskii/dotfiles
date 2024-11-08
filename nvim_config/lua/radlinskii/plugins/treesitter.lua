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

        require("treesitter-context").setup({
            multiwindow = true, -- Enable multiwindow support. TODO: what does it do?
            max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 30, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            multiline_threshold = 5, -- Maximum number of lines to show for a single context
            separator = "─",
        })

        vim.keymap.set("n", "gC", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { silent = true, noremap = true })

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
