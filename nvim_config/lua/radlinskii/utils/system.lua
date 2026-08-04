local M = {
    is_windows = function()
        return vim.loop.os_uname().version:match("Windows")
    end,
    open_in_explorer = function(dir)
        if vim.fn.has("mac") == 1 then
            vim.cmd("silent !open " .. vim.fn.shellescape(dir))
        elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
            -- explorer.exe requires backslashes and no trailing separator
            local win_path = dir:gsub("/", "\\"):gsub("\\+$", "")
            vim.cmd('silent !explorer "' .. win_path .. '"')
        else
            vim.cmd("silent !xdg-open " .. vim.fn.shellescape(dir))
        end
    end,
}

return M
