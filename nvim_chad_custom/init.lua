local autocmd = vim.api.nvim_create_autocmd

vim.opt.nu = true
vim.wo.relativenumber = true

vim.o.scrolloff = 8
vim.opt.colorcolumn = "80"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.shiftwidth = 4

vim.opt.wrap = false
vim.opt.fillchars:append({ diff = "⣿" })
-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

autocmd("FileType", {
    pattern = "help",
    command = ":wincmd L | :vert resize 84",
})
