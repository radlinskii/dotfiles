local opt = vim.opt

opt.laststatus = 3
opt.showmode = false

opt.clipboard = "unnamedplus"

-- allow copy to clipboard through ssh using OSC 52
local function paste()
    return {
        vim.fn.split(vim.fn.getreg(""), "\n"),
        vim.fn.getregtype(""),
    }
end

vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = paste,
        ["*"] = paste,
    },
}

local shellslash_exists = vim.fn.exists("+shellslash") ~= 0

if shellslash_exists then
    opt.shellslash = true
end

-- Indenting
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.breakindent = true -- Enable break indent

opt.spelllang = "en_us"
-- disabled by default, enable with <leader>ns
opt.spell = false

-- Nice and simple folding replacing UFO:
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldtext = ""
opt.foldcolumn = "1"
opt.fillchars:append({
    eob = " ",
    fold = " ",
    foldopen = "▼",
    foldsep = " ",
    foldclose = "▶", -- "⏵","▷","►", "▶"
})

opt.ignorecase = true
opt.smartcase = true

opt.hlsearch = true
opt.incsearch = true
opt.showmatch = true
opt.cmdheight = 1

opt.mouse = "a"

opt.scrolloff = 99999

opt.colorcolumn = "80"
opt.cursorline = true

-- Numbers
opt.numberwidth = 2
opt.relativenumber = true
opt.number = true
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"

opt.splitbelow = true
opt.splitright = true

opt.termguicolors = true

opt.timeoutlen = 400

if vim.fn.has("persistent_undo") then
    local target_path = vim.fn.expand("~/.local/share/nvim/custom_undodir")

    if vim.fn.isdirectory(target_path) == false then
        os.execute("mkdir -p " .. target_path)
    end

    opt.backup = false
    opt.writebackup = false -- no backup files
    opt.swapfile = false -- no swapfiles
    opt.undodir = target_path
    opt.undofile = true
end

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

-- opt.iskeyword:append("-") -- include - in words
opt.path:append("**") -- include subdirs in search

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

vim.opt.guicursor = "n-v-c:block-blinkon1-blinkoff200,i:ver50-blinkon1-blinkoff200"
