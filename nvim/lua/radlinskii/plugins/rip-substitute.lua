---@type LazyPluginSpec
return {
    "chrisgrieser/nvim-rip-substitute",
    keys = {
        {
            "<leader>rr",
            function()
                require("rip-substitute").sub()
            end,
            mode = { "n", "x" },
            desc = " rip substitute",
        },
    },
    config = function()
        require("rip-substitute").setup({
            popupWin = {
                border = "rounded",
            },
            prefill = {
                visual = false, -- "selectionFirstLine"|false
                startInReplaceLineIfPrefill = true,
            },
            incrementalPreview = {
                rangeBackdrop = {
                    blend = 80, -- between 0 and 100
                },
            },
            regexOptions = {
                ---@type "case-sensitive"|"ignore-case"|"smart-case"
                casing = "smart-case",
            },
            editingBehavior = {
                -- Experimental. When typing `()` in the `search` line, automatically
                -- adds `$n` to the `replace` line.
                autoCaptureGroups = true,
            },
        })
    end,
}
