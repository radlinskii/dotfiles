local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

keymap("n", "n", "h", default_opts)
keymap("n", "u", "k", default_opts)
keymap("n", "e", "j", default_opts)
keymap("n", "i", "l", default_opts)

keymap("n", "h", "i", default_opts)
keymap("n", "H", "I", default_opts)
keymap("n", "k", "u", default_opts)
keymap("n", "j", "n", default_opts)
keymap("n", "J", "N", default_opts)
keymap("n", "l", "e", default_opts)
keymap("n", "L", "E", default_opts)
