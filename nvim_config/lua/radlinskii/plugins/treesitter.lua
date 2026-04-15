---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-context",
    },
    init = function()
        local ensure_installed = {
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
        }

        local already_installed = require("nvim-treesitter.config").get_installed()
        local parsers_to_install = vim.iter(ensure_installed)
            :filter(function(parser)
                return not vim.tbl_contains(already_installed, parser)
            end)
            :totable()
        require("nvim-treesitter").install(parsers_to_install)

        require("treesitter-context").setup({
            multiwindow = true,
            max_lines = 10,
            min_window_height = 30,
            multiline_threshold = 5,
            separator = "─",
        })

        require("nvim-ts-autotag").setup({
            opts = {
                enable_close_on_slash = true, -- Auto close on trailing </
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        --- treesitter-context
        vim.keymap.set("n", "gC", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { silent = true, noremap = true, desc = "Go to beginning of the treesitter context" })

        --- incremental-selection
        vim.keymap.set({ "x" }, "[n", function()
            require("vim.treesitter._select").select_prev(vim.v.count1)
        end, { desc = "Select previous treesitter node" })

        vim.keymap.set({ "x" }, "]n", function()
            require("vim.treesitter._select").select_next(vim.v.count1)
        end, { desc = "Select next treesitter node" })

        vim.keymap.set({ "x", "o" }, "an", function()
            if vim.treesitter.get_parser(nil, nil, { error = false }) then
                require("vim.treesitter._select").select_parent(vim.v.count1)
            else
                vim.lsp.buf.selection_range(vim.v.count1)
            end
        end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

        vim.keymap.set({ "x", "o" }, "in", function()
            if vim.treesitter.get_parser(nil, nil, { error = false }) then
                require("vim.treesitter._select").select_child(vim.v.count1)
            else
                vim.lsp.buf.selection_range(-vim.v.count1)
            end
        end, { desc = "Select child treesitter node or inner incremental lsp selections" })
    end,
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        matchup = { enable = true },
    },
}
