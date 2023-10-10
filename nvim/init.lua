local opt = vim.opt
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
vim.shiftwidth = 4 -- no opt?

opt.fillchars = { eob = " ", diff = "⣿" }

opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

vim.o.scrolloff = 8 -- no opt?
opt.colorcolumn = "80"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.nu = true
vim.wo.relativenumber = true -- what's wo?
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with n,i (Colemak),left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]ni")
opt.wrap = false

g.mapleader = " "

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-------------------------------------- autocmds ------------------------------------------

-- dont list quickfix buffers
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

-- open help windows as vertical splits by default
autocmd("FileType", {
    pattern = "help",
    command = ":wincmd L | :vert resize 84",
})
-------------------------------------- globals -----------------------------------------
