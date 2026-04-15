---@type LazyPluginSpec
return {
    -- Collection of various small independent plugins/modules
    "nvim-mini/mini.nvim",
    version = "*",
    lazy = false,
    config = function()
        local animate = require("mini.animate")

        animate.setup({
            cursor = {
                timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
            },
            resize = {
                enable = false,
            },
            scroll = {
                enable = false,
            },
        })
        --
        ------------------------
        --
        require("mini.ai").setup({
            mappings = {
                around_next = "",
                inside_next = "",
            },
        })
        --
        ------------------------
        --
        require("mini.move").setup({
            mappings = {
                line_left = "",
                line_right = "",
                line_down = "",
                line_up = "",
            },
        })
        --
        ------------------------
        --
        require("mini.bracketed").setup()
        --
        ------------------------
        --
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
        --
        ------------------------
        --
        require("mini.pairs").setup()
        --
        ------------------------
        --
        require("mini.trailspace").setup()
        --
        ------------------------
        --
        require("mini.cursorword").setup()
    end,
}
