local opt = vim.opt

opt.laststatus = 3
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.fillchars = { eob = " ", diff = "⣿" }

opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

opt.scrolloff = 99999
opt.colorcolumn = "80"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.nu = true
opt.relativenumber = true
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

-- go to previous/next line with h, l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")
opt.wrap = false

opt.background = "light"
