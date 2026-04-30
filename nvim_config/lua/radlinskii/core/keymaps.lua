-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

-- #
-- Navigation mappings
-- #

keymap.set(
    { "n", "x", "o" },
    "<Up>",
    'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
    { expr = true, silent = true, noremap = true, desc = "Move up" }
)
keymap.set(
    { "n", "x", "o" },
    "<Down>",
    'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
    { expr = true, silent = true, noremap = true, desc = "Move down" }
)
keymap.set({ "n", "x", "o" }, "n", "nzzzv", { silent = true, noremap = true, desc = "Find next appearance" })
keymap.set({ "n", "x", "o" }, "N", "Nzzzv", { silent = true, noremap = true, desc = "Find previous appearance" })

-- #
-- Terminal mode mappings
-- #

keymap.set({ "t" }, "<C-q>", [[<C-\><C-n>]], { silent = true, desc = "Enter normal mode" })

-- #
-- Operator mappings
-- #

-- use something different than tilde for swapping character case because of tilde being a dead key on windows
keymap.set({ "n", "x", "o" }, "gk", "~", { silent = true, noremap = true, desc = "Swap case of next character" })
keymap.set({ "n", "x", "o" }, "gK", "g~", { silent = true, noremap = true, desc = "Swap case of text object" })

-- #
-- Window management mappings
-- #

-- default CTRL_W_d is splitting horizontally
keymap.set("n", "<C-w>d", "<C-w>i<C-w>L", {
    silent = true,
    noremap = true,
    desc = "Split window vertically and go to the declaration of item under the cursor",
})
keymap.set("n", "<C-w>h", "<C-w>s", {
    silent = true,
    noremap = true,
    desc = "Split window horizontally",
})
keymap.set(
    "n",
    "<C-w>l",
    "<C-w>n<C-w>L",
    { silent = true, noremap = true, desc = "Open new buffer in a vertical split" }
)
keymap.set(
    "n",
    "<M-h>",
    ":vertical resize -2<CR>",
    { silent = true, noremap = true, desc = "Resize window vertical -2" }
)
keymap.set(
    "n",
    "<M-l>",
    ":vertical resize +2<CR>",
    { silent = true, noremap = true, desc = "Resize window vertical +2" }
)
keymap.set("n", "<M-k>", ":resize -2<CR>", { silent = true, noremap = true, desc = "Resize window horizontal -2" })
keymap.set("n", "<M-j>", ":resize +2<CR>", { silent = true, noremap = true, desc = "Resize window horizontal +2" })

-- #
-- Scrolling mappings
-- #

keymap.set(
    { "n", "x" },
    "<C-d>",
    "<C-d>zz",
    { silent = true, noremap = true, desc = "Scroll half a window down and move cursor to the center" }
)
keymap.set(
    { "n", "x" },
    "<C-u>",
    "<C-u>zz",
    { silent = true, noremap = true, desc = "Scroll half a window up and move cursor to the center" }
)
keymap.set(
    { "n", "x" },
    "<C-b>",
    "<C-b>zz",
    { silent = true, noremap = true, desc = "Scroll a whole window up and move cursor to the center" }
)
keymap.set(
    { "n", "x" },
    "<C-f>",
    "<C-f>zz",
    { silent = true, noremap = true, desc = "Scroll a whole window down and move cursor to the center" }
)
keymap.set(
    { "n", "x" },
    "<PageUp>",
    "<PageUp>zz",
    { silent = true, noremap = true, desc = "Scroll a whole window up and move cursor to the center" }
)
keymap.set(
    { "n", "x" },
    "<PageDown>",
    "<PageDown>zz",
    { silent = true, noremap = true, desc = "Scroll a whole window down and move cursor to the center" }
)

-- #
-- Insert mode mappings
-- #

-- https://www.reddit.com/r/vim/comments/4w0lib/comment/d63baic/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
keymap.set({ "i" }, "<C-l>", "<ESC>ea", { silent = true, noremap = true, desc = "Move to the end of the word" })
keymap.set({ "i" }, "<C-f>", "<ESC>ldei", { silent = true, noremap = true, desc = "Delete word till the end" })
keymap.set({ "i" }, "<C-j>", "<C-f>", { silent = true, noremap = true, desc = "Reindent line" })

-- <C-b>,<C-f>,<C-j>,<C-k>,<C-l>,<C-/>(<C-_>) are used in some of the plugins e.g. fzf-lua and cmp

-- C-c -> ESC
-- C-m -> CR
-- C-h -> BS
-- C-i -> TAB

-- #
-- Toggle / clear mappings
-- #

keymap.set("n", "<leader>nh", "<cmd> nohl <CR>", { desc = "Clear search highlights", silent = true, noremap = true })
keymap.set(
    "n",
    "<leader>ni",
    "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
    { desc = "Toggle LSP Inlay Hints", silent = true, noremap = true }
)
keymap.set(
    "n",
    "<leader>nb",
    [[<cmd> w <bar> only <bar> %bd <bar> e# <bar> bd# <CR>'"]],
    { desc = "Close other buffers than the current one", silent = true, noremap = true }
)
keymap.set(
    "n",
    "<leader>ns",
    "<cmd>lua vim.opt.spell = not(vim.opt.spell:get()) <CR>",
    { desc = "Toggle spell checking", silent = true, noremap = true }
)
keymap.set(
    "n",
    "<leader>nw",
    "<cmd>lua vim.opt.wrap = not(vim.opt.wrap:get()) <CR>",
    { desc = "Toggle line wrapping", silent = true, noremap = true }
)
keymap.set(
    "n",
    "<leader>nc",
    "<cmd> TSContextToggle <CR>",
    { desc = "Toggle Treesitter Context", silent = true, noremap = true }
)
keymap.set(
    "n",
    "<leader>nt",
    "<cmd> TSToggle highlight <CR>",
    { desc = "Toggle Treesitter highlights", silent = true, noremap = true }
)
keymap.set("n", "<leader>no", function()
    local currentScrolloff = vim.o.scrolloff

    if currentScrolloff == 1 then
        -- the same as in radlinskii/core/options.lua
        vim.o.scrolloff = 99999
    else
        vim.o.scrolloff = 1
    end
end, { desc = "Toggle scrolloff", silent = true, noremap = true })

keymap.set("n", "<leader>nr", function()
    if vim.o.number == false and vim.o.relativenumber == false then
        vim.o.number = true
        print("nu:1/rnu:0")
    elseif vim.o.number == true and vim.o.relativenumber == false then
        vim.o.relativenumber = true
        print("nu:1/rnu:1")
    elseif vim.o.number == true and vim.o.relativenumber == true then
        vim.o.number = false
        print("nu:0/rnu:1")
    else
        vim.o.relativenumber = false
        print("nu:0/rnu:0")
    end
end, { desc = "Cycle line numbers config", silent = true, noremap = true })

-- #
-- Buffer mappings
-- #

keymap.set({ "n" }, "<leader>bw", "<cmd> w <CR>", { desc = "Write buffer", silent = true, noremap = true })
keymap.set(
    "n",
    "<leader>bW",
    "<cmd>noautocmd w<CR>",
    { desc = "Save buffer without running autocommands (autoformat)", silent = true, noremap = true }
)
keymap.set({ "n" }, "<leader>bn", "<cmd> enew <CR>", { desc = "New buffer", silent = true, noremap = true })
keymap.set({ "n" }, "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer", silent = true, noremap = true })
keymap.set({ "n" }, "<leader>bb", "<cmd>b#<CR>", { desc = "Alternate buffer", silent = true, noremap = true })
keymap.set({ "n" }, "<leader>br", "<cmd>e<CR>", { desc = "Reload current buffer", silent = true, noremap = true })
keymap.set({ "n" }, "<leader>bR", "<cmd>restart<CR>", { desc = "Restart nvim", silent = true, noremap = true })

-- #
-- Refactoring mappings
-- #

keymap.set(
    "n",
    "<leader>rs",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { noremap = true, desc = "Substitute current word" }
)
keymap.set(
    "n",
    "<leader>xo",
    "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>",
    { desc = "Open floating diagnostics", silent = true, noremap = true }
)

keymap.set(
    "n",
    "[e",
    "<cmd>lua vim.diagnostic.goto_prev({ severity=vim.diagnostic.severity.ERROR, float = { border = 'rounded' }, wrap = true })<CR>",
    { desc = "Go to prev error diagnostic", silent = true, noremap = true }
)
keymap.set(
    "n",
    "]e",
    "<cmd>lua vim.diagnostic.goto_next({ severity=vim.diagnostic.severity.ERROR, float = { border = 'rounded' }, wrap = true })<CR>",
    { desc = "Go to next error diagnostic", silent = true, noremap = true }
)
keymap.set(
    "n",
    "[d",
    "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' }, wrap = true })<CR>",
    { desc = "Go to prev diagnostic", silent = true, noremap = true }
)
keymap.set(
    "n",
    "]d",
    "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded' }, wrap = true })<CR>",
    { desc = "Go to next diagnostic", silent = true, noremap = true }
)

-- #
-- Copy context range mappings
-- #

keymap.set("n", "<leader>oc", function()
    local filepath = vim.fn.expand("%:p")
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")

    local ref = filepath .. ":L" .. line .. ":C" .. col

    vim.fn.setreg("+", ref)
    vim.fn.setreg("", ref)

    local short_ref = #ref > 75 and "..." .. ref:sub(-72) or ref

    vim.notify(short_ref, vim.log.levels.INFO, { title = "Copied reference" })
end, { desc = "Copy file:line:column reference for AI Agents", silent = false, noremap = true })

keymap.set("v", "<leader>oc", function()
    local filepath = vim.fn.expand("%:p")
    local line_start = vim.fn.line("v")
    local line_end = vim.fn.line(".")

    if line_start > line_end then
        line_start, line_end = line_end, line_start
    end

    local ref = filepath .. ":L" .. line_start .. "-L" .. line_end

    vim.fn.setreg("+", ref)
    vim.fn.setreg("", ref)

    local short_ref = #ref > 75 and "..." .. ref:sub(-72) or ref

    vim.notify(short_ref, vim.log.levels.INFO, { title = "Copied reference" })
end, { desc = "Copy file:line-line range reference for AI Agents", silent = false, noremap = true })

-- #
-- Open current directory in OS file explorer
-- #
keymap.set("n", "<leader>O", function()
    if vim.fn.has("mac") == 1 then
        vim.cmd("silent !open .")
    elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        vim.cmd("silent !explorer .")
    else
        vim.cmd("silent !xdg-open .")
    end
end, { desc = "Open current directory in OS file explorer", silent = true, noremap = true })
