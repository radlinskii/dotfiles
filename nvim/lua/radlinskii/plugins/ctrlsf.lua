return {
    "dyng/ctrlsf.vim",
    event = { "VeryLazy", "BufRead" },
    dependencies = { "folke/which-key.nvim" },
    config = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>s"] = {
                name = "CtrlSF Search",
            },
        })

        vim.keymap.set(
            "n",
            "<leader>sf",
            "<Plug>CtrlSFPrompt",
            { desc = "Provide a phrase to search for", noremap = true, silent = false }
        )
        vim.keymap.set(
            "n",
            "<leader>ss",
            "<Plug>CtrlSFCwordPath",
            { desc = "Provide a phrase to search for word under the cursor", noremap = true, silent = false }
        )
        vim.keymap.set("n", "<leader>sw", "<Plug>CtrlSFCCwordPath", {
            desc = "Provide a phrase to search for word under the cursor with boundaries",
            noremap = true,
            silent = false,
        })
        vim.keymap.set(
            "n",
            "<leader>sp",
            "<Plug>CtrlSFPwordPath",
            { desc = "Provide a phrase to search for the last searched word in vim", noremap = true, silent = false }
        )
        vim.keymap.set(
            "n",
            "<leader>so",
            ":CtrlSFOpen<cr>",
            { desc = "Toggle CtrlSF window", noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>st",
            ":CtrlSFToggle<cr>",
            { desc = "Toggle CtrlSF window", noremap = true, silent = true }
        )

        vim.keymap.set(
            "v",
            "<leader>sf",
            "<Plug>CtrlSFVwordPath",
            { desc = "Provide currently visually selected word to search for", noremap = true, silent = false }
        )

        vim.g.ctrlsf_mapping = {
            open = { "<CR>", "o" },
            openb = "O",
            split = "<C-H>",
            vsplit = "<C-V>",
            tab = "t",
            tabb = "T",
            popen = "p",
            popenf = "P",
            quit = "q",
            next = ")",
            prev = "(",
            nfile = "]",
            pfile = "[",
            pquit = "q",
            loclist = "",
            chgmode = "M",
            stop = "<C-C>",
        }

        vim.g.ctrlsf_auto_focus = {
            at = "done",
            duration_less_than = 1000,
        }

        vim.g.ctrlsf_winsize = 80
    end,
}
