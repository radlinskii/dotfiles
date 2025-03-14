require("radlinskii.core.keymaps")
require("radlinskii.core.options")
require("radlinskii.core.tabline")
require("radlinskii.core.autocmds")
require("radlinskii.core.usercmds")

local is_windows = require("radlinskii.utils.system").is_windows()

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- inlay hints
vim.lsp.inlay_hint.enable()

-- Register the mdx filetype
vim.filetype.add({ extension = { mdx = "mdx" } })

if vim.g.neovide then
    vim.o.guifont = "IosevkaTerm Nerd Font Propo"

    -- Helper function for transparency formatting
    -- local alpha = function()
    --     return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
    -- end
    -- -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
    -- vim.g.neovide_transparency = 0.9
    -- vim.g.transparency = 0.8
    -- vim.g.neovide_background_color = "#0f1117" .. alpha()

    -- vim.g.neovide_fullscreen = true
    vim.g.neovide_remember_window_size = true

    vim.g.neovide_cursor_animate_command_line = true

    vim.g.neovide_cursor_vfx_mode = "ripple"
end
