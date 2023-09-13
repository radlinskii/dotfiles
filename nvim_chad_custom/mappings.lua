---@type MappingsTable
local M = {}

M.general = {
  i = {
    -- navigate within insert mode
    ["<C-n>"] = { "<Left>", "Move left" },
    ["<C-u>"] = { "<Up>", "Move up" },
    ["<C-e>"] = { "<Down>", "Move down" },
    ["<C-i>"] = { "<Right>", "Move right" },
  },
  n = {
    -- switch between windows
    ["<C-n>"] = { "<C-w>h", "Window left" },
    ["<C-i>"] = { "<C-w>l", "Window right" },
    ["<C-e>"] = { "<C-w>j", "Window down" },
    ["<C-u>"] = { "<C-w>k", "Window up" },

    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    ["u"] = {
      'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
      "Move up",
      opts = { expr = true, noremap = true, silent = true },
    },
    ["e"] = {
      'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
      "Move down",
      opts = { expr = true, noremap = true, silent = true },
    },
    ["<Up>"] = {
      'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
      "Move up",
      opts = { expr = true, noremap = true, silent = true },
    },
    ["<Down>"] = {
      'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
      "Move down",
      opts = { expr = true, noremap = true, silent = true },
    },
    ["n"] = { "h", "left", opts = { noremap = true, silent = true } },
    ["i"] = { "l", "right", opts = { noremap = true, silent = true } },

    ["N"] = { "H", "move to beginning of the visible screen", opts = { noremap = true, silent = true } },
    ["I"] = { "L", "move to beginning of the visible screen", opts = { noremap = true, silent = true } },
    ["h"] = { "i", "insert mode in place", opts = { noremap = true, silent = true } },
    ["H"] = {
      "I",
      "start insert mode at the non-blank spaced beginning of current line",
      opts = { noremap = true, silent = true },
    },
    ["k"] = { "u", "undo last change", opts = { noremap = true, silent = true } },
    ["K"] = { "U", "undo all changes", opts = { noremap = true, silent = true } },
    ["j"] = { "n", "find next appearance", opts = { noremap = true, silent = true } },
    ["J"] = { "N", "find previous appearance", opts = { noremap = true, silent = true } },
    ["l"] = { "e", "go to end of the next word", opts = { noremap = true, silent = true } },
    ["gl"] = { "ge", "go to end of the previous word", opts = { noremap = true, silent = true } },
    ["gL"] = { "gE", "go to end of the previous non-blank spaced word", opts = { noremap = true, silent = true } },
    ["L"] = { "E", "go to the end of the next non-blank spaced word", opts = { noremap = true, silent = true } },
    ["E"] = { "J", "remove line break", opts = { noremap = true, silent = true } },
  },
  v = {
    [">"] = { ">gv", "indent" },

    ["<Up>"] = {
      'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
      "Move up",
      opts = { expr = true, noremap = true, silent = true },
    },
    ["<Down>"] = {
      'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
      "Move down",
      opts = { expr = true, noremap = true, silent = true },
    },
  },

  x = {
    ["u"] = {
      'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
      "Move up",
      opts = { expr = true, noremap = true, silent = true },
    },
    ["e"] = {
      'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
      "Move down",
      opts = { expr = true, noremap = true, silent = true },
    },
  },
}

M.lspconfig = {
  n = {
    ["gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },
  },
}

-- more keybinds!

return M
