return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
    config = function(_, opts)
        local status, toggleterm = pcall(require, "toggleterm")
        if not status then
            return
        end

        -- vim.cmd("let &shell = has('win32') ? 'pwsh': 'zsh'")
        -- vim.cmd(
        --     "let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'"
        -- )
        -- vim.cmd("let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'")
        -- vim.cmd("let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'")
        -- vim.cmd("set shellquote= shellxquote=")

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
            close_on_exit = false,
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

        -- local Terminal = require("toggleterm.terminal").Terminal
        -- local node = Terminal:new({ cmd = "node", hidden = true })
        --
        -- function RUN_NODE()
        --     node:toggle()
        -- end
        --
        -- vim.api.nvim_buf_set_keymap(0, "n", ";n", "<Cmd>lua RUN_NODE()<CR>", {})
    end,
}
