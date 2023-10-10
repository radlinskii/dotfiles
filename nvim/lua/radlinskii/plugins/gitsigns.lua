local function on_attach(bufnr)
    local function opts(desc)
        return { desc = "GitSigns: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Define the mappings for Normal mode
    vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
    end, opts("Jump to next hunk"))

    vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
    end, opts("Jump to previous hunk"))

    vim.keymap.set("n", "<leader>cp", "<cmd>Gitsigns preview_hunk<CR>", opts("Preview hunk"))

    vim.keymap.set("n", "<leader>cb", "<cmd>Gitsigns blame_line<CR>", opts("Blame line"))

    vim.keymap.set("n", "<leader>cs", "<cmd>Gitsigns stage_hunk<CR>", opts("Stage hunk"))

    vim.keymap.set("n", "<leader>cu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts("Undo stage hunk"))

    vim.keymap.set("n", "<leader>ca", "<cmd>Gitsigns stage_buffer<CR>", opts("Stage buffer"))

    vim.keymap.set("n", "<leader>cr", "<cmd>Gitsigns reset_hunk<CR>", opts("Reset hunk"))

    vim.keymap.set("n", "<leader>cR", "<cmd>Gitsigns reset_buffer<CR>", opts("Reset buffer"))

    vim.keymap.set("n", "<leader>cd", "<cmd>Gitsigns toggle_deleted<CR>", opts("Toggle deleted"))

    vim.keymap.set("n", "<leader>cc", "<cmd>Gitsigns<CR>", opts("Call GitSigns command"))

    -- Define the mappings for Visual mode
    vim.keymap.set("x", "]c", function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
    end, opts("Jump to next hunk"))

    vim.keymap.set("x", "[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
    end, opts("Jump to previous hunk"))

    vim.keymap.set("x", "<leader>cp", "<cmd>'<,'>Gitsigns preview_hunk<CR>", opts("Preview hunk"))

    vim.keymap.set("x", "<leader>cs", "<cmd>'<,'>Gitsigns stage_hunk<CR>", opts("Stage hunk"))

    vim.keymap.set("x", "<leader>cu", "<cmd>'<,'>Gitsigns undo_stage_hunk<CR>", opts("Undo stage hunk"))

    vim.keymap.set("x", "<leader>cr", "<cmd>'<,'>Gitsigns reset_hunk<CR>", opts("Reset hunk"))

    vim.keymap.set("x", "<leader>cc", "<cmd>'<,'>Gitsigns<CR>", opts("Call GitSigns command on selection"))
end

return {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    init = function()
        -- load gitsigns only when a git file is opened
        vim.api.nvim_create_autocmd({ "BufRead" }, {
            group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
            callback = function()
                vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
                if vim.v.shell_error == 0 then
                    vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
                    vim.schedule(function()
                        require("lazy").load({ plugins = { "gitsigns.nvim" } })
                    end)
                end
            end,
        })
    end,
    opts = {
        on_attach = on_attach,
        signs = {
            add = { text = "▌" },
            change = { text = "▌" },
            delete = { text = "▶" },
            topdelete = { text = "◤" },
            changedelete = { text = "▌" },
            untracked = { text = "▌" },
        },
    },
}
