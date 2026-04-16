vim.pack.add({
    "https://github.com/folke/which-key.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
})

local function on_attach(bufnr)
    local function opts(desc)
        return { desc = "GitSigns: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local wk = require("which-key")
    wk.add({ "<leader>c", group = "Gitsigns" })

    vim.keymap.set("n", "]h", function()
        if vim.wo.diff then
            return "]h"
        end
        vim.schedule(function()
            require("gitsigns").nav_hunk("next")
        end)
        return "<Ignore>"
    end, opts("Jump to next hunk"))

    vim.keymap.set("n", "[h", function()
        if vim.wo.diff then
            return "[h"
        end
        vim.schedule(function()
            require("gitsigns").nav_hunk("prev")
        end)
        return "<Ignore>"
    end, opts("Jump to previous hunk"))

    vim.keymap.set("n", "<leader>cp", "<cmd>Gitsigns preview_hunk<CR>", opts("Preview hunk"))

    vim.keymap.set("n", "<leader>cb", "<cmd>Gitsigns blame_line<CR>", opts("Blame line"))

    vim.keymap.set("n", "<leader>cs", "<cmd>Gitsigns stage_hunk<CR>", opts("Stage hunk"))

    vim.keymap.set("n", "<leader>cu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts("Undo stage hunk"))

    vim.keymap.set("n", "<leader>cS", "<cmd>Gitsigns stage_buffer<CR>", opts("Stage buffer"))

    vim.keymap.set("n", "<leader>cr", "<cmd>Gitsigns reset_hunk<CR>", opts("Reset hunk"))

    vim.keymap.set("n", "<leader>cR", "<cmd>Gitsigns reset_buffer<CR>", opts("Reset buffer"))

    vim.keymap.set("n", "<leader>cd", "<cmd>Gitsigns toggle_deleted<CR>", opts("Toggle deleted"))

    vim.keymap.set("n", "<leader>cc", "<cmd>Gitsigns<CR>", opts("Call GitSigns command"))

    vim.keymap.set(
        "n",
        "<leader>cB",
        "<cmd>G blame<CR>",
        { desc = "Fugitive: Blame buffer", buffer = bufnr, noremap = true, silent = true, nowait = true }
    )

    vim.keymap.set("x", "]h", function()
        if vim.wo.diff then
            return "]h"
        end
        vim.schedule(function()
            require("gitsigns").nav_hunk("next")
        end)
        return "<Ignore>"
    end, opts("Jump to next hunk"))

    vim.keymap.set("x", "[h", function()
        if vim.wo.diff then
            return "[h"
        end
        vim.schedule(function()
            require("gitsigns").nav_hunk("prev")
        end)
        return "<Ignore>"
    end, opts("Jump to previous hunk"))

    vim.keymap.set("x", "<leader>cp", "<cmd>'<,'>Gitsigns preview_hunk<CR>", opts("Preview hunk"))

    vim.keymap.set("x", "<leader>cs", "<cmd>'<,'>Gitsigns stage_hunk<CR>", opts("Stage hunk"))

    vim.keymap.set("x", "<leader>cu", "<cmd>'<,'>Gitsigns undo_stage_hunk<CR>", opts("Undo stage hunk"))

    vim.keymap.set("x", "<leader>cr", "<cmd>'<,'>Gitsigns reset_hunk<CR>", opts("Reset hunk"))

    vim.keymap.set("x", "<leader>cc", "<cmd>'<,'>Gitsigns<CR>", opts("Call GitSigns command on selection"))
end

require("gitsigns").setup({
    current_line_blame = true,
    on_attach = on_attach,
    signs = {
        add = { text = "▌" },
        change = { text = "▌" },
        delete = { text = "▶" },
        topdelete = { text = "◤" },
        changedelete = { text = "▌" },
        untracked = { text = "▌" },
    },
})
