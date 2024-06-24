local is_windows = vim.loop.os_uname().version:match("Windows")

local M = {
    is_windows,
}

return M
