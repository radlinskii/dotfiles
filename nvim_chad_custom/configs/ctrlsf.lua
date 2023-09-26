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
