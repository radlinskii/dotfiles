local is_windows = require("radlinskii.utils.system").is_windows()
local path_separator = is_windows and "\\" or "/"

local M = {
    separator = path_separator,
    exists = function(filename)
        local stat = vim.loop.fs_stat(filename)
        return stat ~= nil
    end,
    join = function(...)
        return table
            .concat(vim.iter({ ... }):flatten():totable(), path_separator)
            :gsub(path_separator .. "+", path_separator)
    end,
}

return M
