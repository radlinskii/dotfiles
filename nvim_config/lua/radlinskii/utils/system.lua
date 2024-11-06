local M = {
    is_windows = function()
        return vim.loop.os_uname().version:match("Windows")
    end,
}

return M
