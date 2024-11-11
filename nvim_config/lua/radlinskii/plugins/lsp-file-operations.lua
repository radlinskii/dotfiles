---@type LazyPluginSpec
return {
    "antosha417/nvim-lsp-file-operations",
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
    },
    event = { "VeryLazy" },
    config = function()
        require("lsp-file-operations").setup()
    end,
}
