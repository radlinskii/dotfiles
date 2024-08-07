---@type LazyPluginSpec
return {
    "ryanmsnyder/toggleterm-manager.nvim",
    keys = {
        { "<C-\\>", desc = "ToggleTerm" },
        {
            "<leader>ft",
            "<cmd>Telescope toggleterm_manager<cr>",
            desc = "Find Open ToggleTerm terminals",
        },
    },
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
        {
            "akinsho/toggleterm.nvim",
            config = function()
                local toggleterm = require("toggleterm")
                local is_windows = require("radlinskii.utils.system").is_windows()

                toggleterm.setup({
                    shell = function()
                        if is_windows then
                            return "pwsh"
                        else
                            return vim.o.shell
                        end
                    end,
                    size = function(term)
                        if term.direction == "horizontal" then
                            return 20
                        elseif term.direction == "vertical" then
                            return vim.o.columns * 0.4
                        end
                    end,
                    open_mapping = [[<C-\>]],
                    hide_numbers = true,
                    shade_filetypes = {},
                    shade_terminals = true,
                    shading_factor = 2,
                    start_in_insert = true,
                    insert_mappings = true,
                    persist_size = true,
                    close_on_exit = true,
                    direction = "float",
                    float_opts = {
                        border = "curved",
                        winblend = 0,
                        highlights = {
                            border = "Normal",
                            background = "Normal",
                        },
                    },
                    highlights = {
                        Normal = {
                            guibg = "#ffffcc",
                        },
                    },
                })

                -- disable to fix lazygit
                -- function _G.set_terminal_keymaps()
                --     local opts = { buffer = 0 }
                --     vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
                -- end
                --
                -- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
            end,
        },
    },
    config = function()
        local toggletermManager = require("toggleterm-manager")

        toggletermManager.setup({
            mappings = {
                i = { ["<C-x>"] = { action = toggletermManager.actions.delete_term, exit_on_action = false } },
                n = { ["<x>"] = { action = toggletermManager.actions.delete_term, exit_on_action = false } },
            },
        })
    end,
}
