local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "nvimtools/none-ls.nvim",
                config = function()
                    require("custom.configs.null-ls")
                end,
            },
        },
        config = function()
            require("plugins.configs.lspconfig")
            require("custom.configs.lspconfig")
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-context" },
        opts = overrides.treesitter,
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },

    {
        "nvim-telescope/telescope.nvim",
        opts = overrides.telescope,
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = overrides.gitsigns,
    },

    {
        "numToStr/Comment.nvim",
        dependencies = { "nvim-treesitter", "JoosepAlviste/nvim-ts-context-commentstring" },
        after = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require("custom.configs.comment")
        end,
    },

    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", '"', "'", "`", "d", "c", "v", "g", "z", "<c-w>", "[", "]" },
    },

    {
        "tpope/vim-fugitive",
        lazy = false,
        opts = overrides.fugitive,
    },

    {
        "sindrets/diffview.nvim",
        lazy = false,
    },

    {
        "ThePrimeagen/harpoon",
        event = "BufReadPre",
        config = function()
            require("harpoon").setup()
        end,
    },

    { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },

    {
        "mbbill/undotree",
        event = "BufReadPre",
        config = function()
            require("custom.configs.undotree")
        end,
    },

    {
        "dyng/ctrlsf.vim",
        event = "BufRead",
        config = function()
            require("custom.configs.ctrlsf")
        end,
    },

    {
        "andymass/vim-matchup",
        event = "BufReadPre",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    require("custom.configs.statuscol")
                end,
            },
        },
        event = "BufRead",
        config = function()
            require("custom.configs.ufo")
        end,
    },

    -- lang specific

    -- rust
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = "neovim/nvim-lspconfig",
        opts = function()
            return require("custom.configs.rust-tools")
        end,
        config = function(_, opts)
            require("rust-tools").setup(opts)
        end,
    },
    {

        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        config = function(_, opts)
            local crates = require("crates")
            crates.setup(opts)
            crates.show()
        end,
    },
}

return plugins
