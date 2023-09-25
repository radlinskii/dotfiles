local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "jose-elias-alvarez/null-ls.nvim",
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
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", '"', "'", "`", "d", "c", "v", "g", "z", "<c-w>", "[", "]" },
    },

    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git" },
        opts = overrides.fugitive,
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
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_DiffAutoOpen = 0
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_HelpLine = 0
            vim.g.Undotree_CustomMap = function()
                local b = { buffer = 0 }
                vim.keymap.set("n", "q", "<Plug>UndotreeClose", b)
                vim.keymap.set("n", "u", "<plug>UndotreeNextState", b)
                vim.keymap.set("n", "e", "<plug>UndotreePreviousState", b)
                vim.keymap.set("n", "k", "<plug>UndotreeUndo", b)
                vim.keymap.set("n", "J", "<Nop>", b)
                vim.keymap.set("n", "K", "<Nop>", b)
                vim.keymap.set("n", "U", "<Nop>", b)
                vim.keymap.set("n", "C", "<Nop>", b)
            end
        end,
    },

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
