vim.pack.add({
    { src = 'https://github.com/s1n7ax/nvim-window-picker', name = 'window-picker' },
})

require("window-picker").setup({
    hint = "floating-big-letter",
    selection_chars = "TNSERIAOPFWQLUY",
    filter_rules = {
        include_current_win = true,
    },
})