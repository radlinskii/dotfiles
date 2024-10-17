-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General Keymaps -------------------

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

-- window management
-- defualt CTRL_W_d is splitting horizontally
keymap.set("n", "<C-w>d", "<C-w>i<C-w>L", {
    silent = true,
    noremap = true,
    desc = "Split window vertically and go to the declaration of item under the cursor",
})
keymap.set("n", "<C-w>/", "<C-w>v", {
    silent = true,
    noremap = true,
    desc = "Split window vertically",
})
keymap.set("n", "<C-w>x", "<C-w>s", {
    silent = true,
    noremap = true,
    desc = "Split window horizontally",
})
keymap.set("n", "<C-w>s", "<C-w>x", {
    silent = true,
    noremap = true,
    desc = "Swap current with next",
})
keymap.set(
    "n",
    "<C-w>l",
    "<C-w>n<C-w>L",
    { silent = true, noremap = true, desc = "Open new buffer in a vertical split" }
)

-- scroll
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

-- use something different than tilde for swapping character case because of tilde being a dead key on windows
keymap.set({ "n", "x", "o" }, "gk", "~", { silent = true, noremap = true, desc = "Swap case of next character" })
keymap.set({ "n", "x", "o" }, "gK", "g~", { silent = true, noremap = true, desc = "Swap case of text object" })

-- visual/select
keymap.set({ "x" }, ">", ">gv", { silent = true, noremap = true, desc = "Increase indent" })
keymap.set({ "x" }, "<", "<gv", { silent = true, noremap = true, desc = "Increase indent" })
keymap.set({ "x" }, "J", ":m '>+1<CR>gv=gv", { silent = true, noremap = true, desc = "Move selected lines up" })
keymap.set({ "x" }, "K", ":m '<-2<CR>gv=gv", { silent = true, noremap = true, desc = "Move selected lines down" })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
keymap.set(
    { "x" },
    "p",
    'p:let @+=@0<CR>:let @"=@0<CR>',
    { desc = "Don't copy replaced text", silent = true, noremap = true }
)

keymap.set(
    { "x" },
    "<leader>rs",
    [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { noremap = true, desc = "Substitute current word inside the selection" }
)

--insert
-- https://www.reddit.com/r/vim/comments/4w0lib/comment/d63baic/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
keymap.set({ "i" }, "<C-l>", "<ESC>ea", { silent = true, noremap = true, desc = "Move to the end of the word" })
keymap.set({ "i" }, "<C-f>", "<ESC>ldei", { silent = true, noremap = true, desc = "Delete word till the end" })
keymap.set({ "i" }, "<C-j>", "<C-f>", { silent = true, noremap = true, desc = "Reindent line" })

-- <C-b>,<C-f>,<C-j>,<C-k>,<C-l>,<C-/>(<C-_>) are used in some of the plugins e.g. telescope and cmp

-- C-c -> ESC
-- C-m -> CR
-- C-h -> BS
-- C-i -> TAB

-- normal
keymap.set("n", "<leader>nh", "<cmd> nohl <CR>", { desc = "Clear search highlights", silent = true, noremap = true })
keymap.set(
    "n",
    "<leader>ni",
    "<CMD>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
    { desc = "Toggle LSP Inlay Hints", silent = true, noremap = true }
)
keymap.set(
    "n",
    "<leader>nw",
    "<cmd>only<CR>",
    { desc = "Close other windows than the current one", silent = true, noremap = true }
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
    "<cmd>noautocmd w<CR>",
    { desc = "Save buffer without running autocommands (autoformat)", silent = true, noremap = true }
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

keymap.set(
    "n",
    "<leader>rs",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { noremap = true, desc = "Substitute current word" }
)
keymap.set({ "n" }, "<leader>w", "<cmd> w <CR>", { desc = "Write file", silent = true, noremap = true })
keymap.set({ "n" }, "<leader>b", "<cmd> enew <CR>", { desc = "New buffer", silent = true, noremap = true })

keymap.set(
    "n",
    "<leader>ro",
    "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>",
    { desc = "Open floating diagnostics", silent = true, noremap = true }
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
