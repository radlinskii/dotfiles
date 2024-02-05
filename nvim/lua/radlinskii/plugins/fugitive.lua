return {
    "tpope/vim-fugitive",
    lazy = false,
    init = function()
        vim.keymap.set("n", "<leader>g", function()
            local fugitive_buf_no = vim.fn.bufnr("^fugitive:")
            local buf_win_id = vim.fn.bufwinid(fugitive_buf_no)
            if fugitive_buf_no >= 0 and buf_win_id >= 0 then
                vim.api.nvim_win_close(buf_win_id, false)
            else
                if vim.o.lines > 75 then
                    vim.cmd(":G")
                else
                    vim.cmd(":vert G")
                end
            end
        end, { desc = "Toggle fugitive", noremap = true, silent = true })
    end,
}
