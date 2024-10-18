---@type LazyPluginSpec
return {
    "dyng/ctrlsf.vim",
    keys = {
        {
            "<leader>sf",
            "<Plug>CtrlSFPrompt -hidden ",
            desc = "Provide a phrase to search for",
        },
        {
            "<leader>sc",
            "<Plug>CtrlSFCwordPath -hidden ",
            desc = "Provide a phrase to search for word under the cursor",
        },
        {
            "<leader>sw",
            "<Plug>CtrlSFCCwordPath -hidden ",
            desc = "Provide a phrase to search for word under the cursor with boundaries",
        },
        {
            "<leader>sp",
            "<Plug>CtrlSFPwordPath -hidden ",
            desc = "Provide a phrase to search for the last searched word in vim",
        },
        {
            "<leader>so",
            ":CtrlSFOpen<cr> -hidden ",
            desc = "Open CtrlSF window",
        },
        {
            "<leader>st",
            ":CtrlSFToggle <cr>",
            desc = "Toggle CtrlSF window",
        },
        -- visual mode
        {
            "<leader>sf",
            "<Plug>CtrlSFVwordPath -hidden ",
            desc = "Provide currently visually selected word to search for",
            mode = { "x" },
        },
    },
    cmd = {
        "CtrlSF",
        "CtrlSFOpen",
        "CtrlSFPrompt",
        "CtrlSFToggle",
        "CtrlSFCwordPath",
        "CtrlSFPwordPath",
        "CtrlSFVwordPath",
        "CtrlSFCCwordPath",
    },
    config = function()
        -- pass path as 3rd argument,
        -- e.g. :CtrlSF desc **/core
        -- https://github.com/dyng/ctrlsf.vim/issues/313

        vim.g.ctrlsf_mapping = {
            open = { "<CR>", "o" },
            openb = "O",
            split = "<C-X>",
            vsplit = { "<C-/>", "<C-_>" },
            tab = "t",
            tabb = "T",
            popen = "p",
            popenf = "P",
            quit = "q",
            next = ")",
            prev = "(",
            nfile = "]",
            pfile = "[",
            pquit = { "<C-c>" },
            loclist = "",
            chgmode = "M",
            stop = "<C-e>",
        }

        vim.g.ctrlsf_auto_focus = {
            at = "done",
            duration_less_than = 1000,
        }

        vim.g.ctrlsf_winsize = 80

        -- added an alias for ag
        -- to always ignore some directories
        -- check custom_aliases.sh
    end,
}
