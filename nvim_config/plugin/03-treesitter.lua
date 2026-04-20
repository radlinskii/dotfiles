vim.pack.add({
    "https://github.com/windwp/nvim-ts-autotag",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

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

require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        -- syntax highlighting, provided by Neovim
        if pcall(vim.treesitter.start, args.buf) then
            -- folds, provided by Neovim
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- indentation, provided by nvim-treesitter
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})

require("treesitter-context").setup({
    multiwindow = true,
    max_lines = 10,
    min_window_height = 30,
    multiline_threshold = 5,
    separator = "─",
})

require("nvim-ts-autotag").setup({
    opts = {
        enable_close_on_slash = true,
    },
})

require("nvim-treesitter-textobjects").setup({
    select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "v",
            ["@class.outer"] = "V", -- linewise
        },
        include_surrounding_whitespace = true,
    },
    move = {
        set_jumps = true,
    },
})

-- keymaps for =,f,m,c,i,l

local opts = { noremap = true, silent = true }

-- select
opts.desc = "Select left side of assignment"
vim.keymap.set({ "x", "o" }, "l=", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@assignment.lhs", "textobjects")
end, opts)
opts.desc = "Select right side of assignment"
vim.keymap.set({ "x", "o" }, "r=", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@assignment.rhs", "textobjects")
end, opts)
opts.desc = "Select function call (outer)"
vim.keymap.set({ "x", "o" }, "af", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@call.outer", "textobjects")
end, opts)
opts.desc = "Select function call (inner)"
vim.keymap.set({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@call.inner", "textobjects")
end, opts)
opts.desc = "Select function (outer)"
vim.keymap.set({ "x", "o" }, "am", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, opts)
opts.desc = "Select function (inner)"
vim.keymap.set({ "x", "o" }, "im", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, opts)
opts.desc = "Select class (outer)"
vim.keymap.set({ "x", "o" }, "ac", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, opts)
opts.desc = "Select class (inner)"
vim.keymap.set({ "x", "o" }, "ic", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, opts)
opts.desc = "Select conditional (outer)"
vim.keymap.set({ "x", "o" }, "ai", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
end, opts)
opts.desc = "Select conditional (inner)"
vim.keymap.set({ "x", "o" }, "ii", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
end, opts)
opts.desc = "Select loop (outer)"
vim.keymap.set({ "x", "o" }, "al", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
end, opts)
opts.desc = "Select loop (inner)"
vim.keymap.set({ "x", "o" }, "il", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
end, opts)

-- move
opts.desc = "Go to next assignment start"
vim.keymap.set({ "n", "x", "o" }, "]=", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@assignment.outer", "textobjects")
end, opts)
opts.desc = "Go to next function call start"
vim.keymap.set({ "n", "x", "o" }, "]f", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@call.outer", "textobjects")
end, opts)
opts.desc = "Go to next function start"
vim.keymap.set({ "n", "x", "o" }, "]m", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, opts)
opts.desc = "Go to next class start"
vim.keymap.set({ "n", "x", "o" }, "]c", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end, opts)
opts.desc = "Go to next conditional start"
vim.keymap.set({ "n", "x", "o" }, "]i", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@conditional.outer", "textobjects")
end, opts)
opts.desc = "Go to next loop start"
vim.keymap.set({ "n", "x", "o" }, "]l", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@loop.outer", "textobjects")
end, opts)

opts.desc = "Go to next function call end"
vim.keymap.set({ "n", "x", "o" }, "]F", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@call.outer", "textobjects")
end, opts)
opts.desc = "Go to next function end"
vim.keymap.set({ "n", "x", "o" }, "]M", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end, opts)
opts.desc = "Go to next class end"
vim.keymap.set({ "n", "x", "o" }, "]C", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end, opts)
opts.desc = "Go to next conditional end"
vim.keymap.set({ "n", "x", "o" }, "]I", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@conditional.outer", "textobjects")
end, opts)
opts.desc = "Go to next loop end"
vim.keymap.set({ "n", "x", "o" }, "]L", function()
    require("nvim-treesitter-textobjects.move").goto_next_end("@loop.outer", "textobjects")
end, opts)

opts.desc = "Go to previous assignment start"
vim.keymap.set({ "n", "x", "o" }, "[=", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@assignment.outer", "textobjects")
end, opts)
opts.desc = "Go to previous function call start"
vim.keymap.set({ "n", "x", "o" }, "[f", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@call.outer", "textobjects")
end, opts)
opts.desc = "Go to previous function start"
vim.keymap.set({ "n", "x", "o" }, "[m", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, opts)
opts.desc = "Go to previous class start"
vim.keymap.set({ "n", "x", "o" }, "[c", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end, opts)
opts.desc = "Go to previous conditional start"
vim.keymap.set({ "n", "x", "o" }, "[i", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@conditional.outer", "textobjects")
end, opts)
opts.desc = "Go to previous loop start"
vim.keymap.set({ "n", "x", "o" }, "[l", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@loop.outer", "textobjects")
end, opts)

opts.desc = "Go to previous function call end"
vim.keymap.set({ "n", "x", "o" }, "[F", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@call.outer", "textobjects")
end, opts)
opts.desc = "Go to previous function end"
vim.keymap.set({ "n", "x", "o" }, "[M", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end, opts)
opts.desc = "Go to previous class end"
vim.keymap.set({ "n", "x", "o" }, "[C", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end, opts)
opts.desc = "Go to previous conditional end"
vim.keymap.set({ "n", "x", "o" }, "[I", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@conditional.outer", "textobjects")
end, opts)
opts.desc = "Go to previous loop end"
vim.keymap.set({ "n", "x", "o" }, "[L", function()
    require("nvim-treesitter-textobjects.move").goto_previous_end("@loop.outer", "textobjects")
end, opts)

vim.keymap.set("n", "gC", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, noremap = true, desc = "Go to beginning of the treesitter context" })

vim.cmd("TSUpdate")
