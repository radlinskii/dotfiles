vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/f-person/auto-dark-mode.nvim",
})

require("auto-dark-mode").setup({
    update_interval = 3000,
    fallback = "dark",
    set_dark_mode = function()
        require("radlinskii.utils.theme").set_dark_mode()
    end,
    set_light_mode = function()
        require("radlinskii.utils.theme").set_light_mode()
    end,
})
