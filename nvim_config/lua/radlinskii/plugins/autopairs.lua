---@type LazyPluginSpec
return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true, -- enable treesitter
            ts_config = {
                lua = { "string" }, -- don't add pairs in lua string treesitter nodes
                javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter nodes
                java = false, -- don't check treesitter on java
            },
        })
    end,
}
