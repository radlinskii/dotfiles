vim.pack.add({
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
})

---@type blink.cmp.Config
require("blink.cmp").setup({
    keymap = {
        preset = "super-tab",
        ["<C-k>"] = { "cancel" },
        ["<C-e>"] = { "hide" },
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
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            buffer = {
                opts = {
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
            ["<C-k>"] = { "cancel" },
            ["<C-e>"] = { "hide" },
            ["<C-j>"] = { "show_signature", "hide_signature", "fallback" },
            ["<C-_>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-/>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-p>"] = {},
            ["<C-n>"] = {},
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
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
})
