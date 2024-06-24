return {
    "ryanmsnyder/toggleterm-manager.nvim",
    dependencies = {
        "folke/which-key.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
        {
            "akinsho/toggleterm.nvim",
            config = function()
                local toggleterm = require("toggleterm")
                local is_windows = vim.loop.os_uname().version:match("Windows")

                toggleterm.setup({
                    shell = function()
                        if is_windows then
                            return "pwsh.exe"
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
                function _G.set_terminal_keymaps()
                    local opts = { buffer = 0 }
                    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
                end

                vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
            end,
        },
    },
    config = function(_, opts)
        local toggletermManager = require("toggleterm-manager")

        toggletermManager.setup(opts)

        vim.keymap.set("n", "<leader>ft", "<cmd>Telescope toggleterm_manager<cr>", {
            desc = "Toggle trouble window",
            noremap = true,
            silent = true,
        })
    end,
}
