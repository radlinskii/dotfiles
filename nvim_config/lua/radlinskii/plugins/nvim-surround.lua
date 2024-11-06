---@type LazyPluginSpec
return {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        keymaps = {
            visual = "gs",
        },
    },
}
