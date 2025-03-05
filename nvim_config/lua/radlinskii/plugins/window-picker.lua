---@type LazyPluginSpec
return {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
        require("window-picker").setup({
            hint = "floating-big-letter",
            selection_chars = "TNSERIAOPFWQLUY",
            filter_rules = {
                include_current_win = true,
            },
        })
    end,
}
