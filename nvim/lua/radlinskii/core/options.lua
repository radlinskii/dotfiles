local opt = vim.opt

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

-- go to previous/next line with h, j,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- opt.whichwrap:append("<>[]hj")
opt.wrap = false

