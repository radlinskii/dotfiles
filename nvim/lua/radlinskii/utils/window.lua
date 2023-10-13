local M = {}

function M.close_all_floating_wins()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= "" then
            vim.api.nvim_win_close(win, false)
        end
    end
end

function M.close_all_nvim_tree_buffers()
    local targetBuffers = {}
    local bufList = vim.api.nvim_list_bufs()

    for _, buf in ipairs(bufList) do
        local bufName = vim.api.nvim_buf_get_name(buf)

        if string.match(bufName, "NvimTree") then
            table.insert(targetBuffers, buf)
        end
    end

    for _, buf in ipairs(targetBuffers) do
        vim.api.nvim_buf_delete(buf, { force = true })
    end
end

return M
