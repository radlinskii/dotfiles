local opt = vim.opt

opt.laststatus = 3
opt.showmode = false

opt.clipboard = "unnamedplus"

local shellslash_exists = vim.fn.exists("+shellslash") ~= 0

if shellslash_exists then
    opt.shellslash = true
end

-- Indenting
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.fillchars = {
    diff = "⣿",
    eob = " ",
    fold = " ",
    foldopen = "▼",
    foldsep = " ",
    foldclose = "▶", -- "⏵","▷","►", "▶"
}

opt.ignorecase = true
opt.smartcase = true

opt.mouse = "a"

opt.scrolloff = 99999

opt.colorcolumn = "80"
opt.cursorline = true

-- Numbers
opt.numberwidth = 2
opt.relativenumber = false
opt.number = false
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"

opt.splitbelow = true
opt.splitright = true

opt.termguicolors = true

opt.timeoutlen = 400

opt.undofile = true

-- Enable break indent
opt.breakindent = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- opt.list = true
-- opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
-- opt.inccommand = "split"

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h, l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")
opt.wrap = false

-- this will get later anyway overridden by auto-dark-mode.nvim
-- but with this, there is less blinking on the initial load,
-- before the auto-dark-mode plugin is called
local function set_initial_background()
    local hour = tonumber(os.date("%H"))

    if hour >= 8 and hour < 17 then
        opt.background = "light"
    else
        opt.background = "dark"
    end
end

set_initial_background()

-- recommended for AutoSession
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
