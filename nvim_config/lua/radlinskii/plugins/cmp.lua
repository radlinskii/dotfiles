---@type LazyPluginSpec
return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*", -- use a release tag to download pre-built binaries
    opts = {
        keymap = {
            preset = "super-tab",
            ["<C-k>"] = { "cancel" }, -- "k"ancel
            ["<C-e>"] = { "hide" }, -- hid"e"
            ["<C-j>"] = { "show_signature", "hide_signature", "fallback" },
            ["<C-_>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-/>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-p>"] = {},
            ["<C-n>"] = {},
            ["<CR>"] = { "accept", "fallback" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                buffer = {
                    opts = {
                        -- filter to only "normal" buffers
                        get_bufnrs = function()
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == ""
                            end, vim.api.nvim_list_bufs())
                        end,
                    },
                },
            },
        },
        cmdline = {
            keymap = {
                preset = "super-tab",
                ["<C-k>"] = { "cancel" }, -- "k"ancel
                ["<C-e>"] = { "hide" }, -- hid"e"
                ["<C-j>"] = { "show_signature", "hide_signature", "fallback" },
                ["<C-_>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-/>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-p>"] = {},
                ["<C-n>"] = {},
                -- ["<CR>"] = { "accept", "fallback" },
            },
            completion = {
                menu = {
                    auto_show = true,
                },
            },
        },
        completion = {
            list = { selection = { preselect = true, auto_insert = true } },
            accept = {
                auto_brackets = { enabled = true },
            },
            menu = {
                auto_show = true,
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind", gap = 1 },
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
        },
    },
    opts_extend = { "sources.default" },
}
