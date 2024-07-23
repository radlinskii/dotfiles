-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General Keymaps -------------------

-- colemak
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
keymap.set(
    { "n", "x", "o" },
    "u",
    'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
    { expr = true, silent = true, noremap = true, desc = "Move up" }
)
keymap.set(
    { "n", "x", "o" },
    "e",
    'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
    { expr = true, silent = true, noremap = true, desc = "Move down" }
)
keymap.set({ "n", "x", "o" }, "n", "h", { silent = true, noremap = true, desc = "Move left" })
keymap.set({ "n", "x", "o" }, "i", "l", { silent = true, noremap = true, desc = "Move right" })

keymap.set(
    { "n", "x", "o" },
    "N",
    "H",
    { silent = true, noremap = true, desc = "Go to [count] top line of the window" }
)
keymap.set(
    { "n", "x", "o" },
    "I",
    "L",
    { silent = true, noremap = true, desc = "Go to [count] Last line of the window" }
)
keymap.set({ "n", "x", "o" }, "h", "i", { silent = true, noremap = true, desc = "Insert mode in place" })
keymap.set(
    { "n", "x", "o" },
    "H",
    "I",
    { silent = true, noremap = true, desc = "Start insert mode at the non-blank-spaced beginning of current line" }
)
keymap.set({ "n", "x", "o" }, "k", "u", { silent = true, noremap = true, desc = "Undo last change" })
keymap.set({ "n", "x", "o" }, "K", "U", { silent = true, noremap = true, desc = "Undo all latest changes in one line" })
keymap.set({ "n", "x", "o" }, "j", "nzzzv", { silent = true, noremap = true, desc = "Find next appearance" })
keymap.set({ "n", "x", "o" }, "J", "Nzzzv", { silent = true, noremap = true, desc = "Find previous appearance" })
keymap.set({ "n", "x", "o" }, "l", "e", { silent = true, noremap = true, desc = "Go to end of the next word" })
keymap.set(
    { "n", "x", "o" },
    "L",
    "E",
    { silent = true, noremap = true, desc = "Go to the end of the next non-blank-spaced word" }
)
keymap.set(
    { "n", "x", "o" },
    "gl",
    "ge",
    { silent = true, noremap = true, desc = "Go to the end of the previous word" }
)
keymap.set(
    { "n", "x", "o" },
    "gL",
    "gE",
    { silent = true, noremap = true, desc = "Go to the end of the previous non-blank-spaced word" }
)

keymap.set({ "n", "x", "o" }, "E", "J", { silent = true, noremap = true, desc = "Remove line break" })
keymap.set(
    { "n", "x", "o" },
    "gE",
    "gJ",
    { silent = true, noremap = true, desc = "Remove line break without trimming whitespace" }
)
keymap.set(
    { "n", "x", "o" },
    "gH",
    "gI",
    { silent = true, noremap = true, desc = "Start insert mode at the 1st column" }
)
keymap.set(
    { "n", "x", "o" },
    "gh",
    "gi",
    { silent = true, noremap = true, desc = "Start insert mode at the last position in insert mode" }
)
keymap.set({ "n", "x", "o" }, "gi", "gh", { silent = true, noremap = true, desc = "Start Select mode" })
keymap.set({ "n", "x", "o" }, "gI", "gH", { silent = true, noremap = true, desc = "Start Select-Line mode" })
keymap.set(
    { "n", "x", "o" },
    "gj",
    "gn",
    { silent = true, noremap = true, desc = "Find the next match and visually select it" }
)
keymap.set(
    { "n", "x", "o" },
    "gJ",
    "gN",
    { silent = true, noremap = true, desc = "Find the previous match and visually select it" }
)

keymap.set({ "n", "x", "o" }, "zN", "zH", { silent = true, noremap = true, desc = "Scroll left half a screen width" })
keymap.set({ "n", "x", "o" }, "zn", "zh", { silent = true, noremap = true, desc = "Scroll N columns left" })
keymap.set({ "n", "x", "o" }, "zI", "zL", { silent = true, noremap = true, desc = "Scroll right half a screen width" })
keymap.set({ "n", "x", "o" }, "zi", "zl", { silent = true, noremap = true, desc = "Scroll N columns right" })
keymap.set({ "n", "x", "o" }, "zl", "zi", { silent = true, noremap = true, desc = "Toggle foldenable" })
keymap.set(
    { "n", "x", "o" },
    "[Z",
    "zk",
    { silent = true, noremap = true, desc = "Move to the end of the previous fold" }
)
keymap.set(
    { "n", "x", "o" },
    "]z",
    "zj",
    { silent = true, noremap = true, desc = "Move to the start of the next fold" }
)

-- windows
keymap.set("n", "<C-w>u", "<C-w>k", { silent = true, noremap = true, desc = "Focus window up" })
keymap.set("n", "<C-w>e", "<C-w>j", { silent = true, noremap = true, desc = "Focus window down" })
keymap.set("n", "<C-w>n", "<C-w>h", { silent = true, noremap = true, desc = "Focus window left" })
keymap.set("n", "<C-w>i", "<C-w>l", { silent = true, noremap = true, desc = "Focus window right" })

keymap.set("n", "<C-w>U", "<C-w>K", { silent = true, noremap = true, desc = "Move current window to the very top" })
keymap.set("n", "<C-w>E", "<C-w>J", { silent = true, noremap = true, desc = "Move current window to the very bottom" })
keymap.set("n", "<C-w>N", "<C-w>H", { silent = true, noremap = true, desc = "Move current window to the far left" })
keymap.set("n", "<C-w>I", "<C-w>L", { silent = true, noremap = true, desc = "Move current window to the far right" })

keymap.set(
    "n",
    "<C-w><C-u>",
    "<C-w>+",
    { silent = true, noremap = true, desc = "Increase current window height N lines" }
)
keymap.set(
    "n",
    "<C-w><C-e>",
    "<C-w>-",
    { silent = true, noremap = true, desc = "Decrease current window height N lines" }
)
keymap.set(
    "n",
    "<C-w><C-i>",
    "<C-w>>",
    { silent = true, noremap = true, desc = "Increase current window width N columns" }
)
keymap.set(
    "n",
    "<C-w><C-n>",
    "<C-w><",
    { silent = true, noremap = true, desc = "Decrease current window width N columns" }
)

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
    "<PageUp>zz",
    { silent = true, noremap = true, desc = "Scroll a whole window up and move cursor to the center" }
)
keymap.set(
    { "n", "x" },
    "<C-f>",
    "<PageDown>zz",
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
keymap.set({ "x" }, "E", ":m '>+1<CR>gv=gv", { silent = true, noremap = true, desc = "Move selected lines up" })
keymap.set({ "x" }, "U", ":m '<-2<CR>gv=gv", { silent = true, noremap = true, desc = "Move selected lines down" })

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
keymap.set({ "i" }, "<C-b>", "<ESC>^i", { silent = true, noremap = true, desc = "Move to the beginning of line" })
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
    "<leader>nr",
    "<CMD>set rnu! rnu?<CR>",
    { desc = "Toggle between relative and absolute line numbers", silent = true, noremap = true }
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

keymap.set(
    "n",
    "<leader>rs",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { noremap = true, desc = "Substitute current word" }
)

keymap.set({ "n" }, "<C-s>", "<cmd> w <CR>", { desc = "Save file", silent = true, noremap = true })
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
