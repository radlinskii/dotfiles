---@type LazyPluginSpec[]
return {
    {
        enabled = not require("radlinskii.utils.system").is_windows(),
        "karb94/neoscroll.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            duration_multiplier = 0.5,
        },
    },
}
