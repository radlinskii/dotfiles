local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    local lazy_repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazy_repo, lazy_path })
end

vim.opt.rtp:prepend(lazy_path)

require("lazy.view.config").commands.update.key_plugin = "gu"
require("lazy.view.config").keys.close = "<c-c>"
require("lazy.view.config").keys.abort = "q"

require("lazy").setup({ { import = "radlinskii.plugins" } }, {
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { "kanagawa" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = true,
    },
})
