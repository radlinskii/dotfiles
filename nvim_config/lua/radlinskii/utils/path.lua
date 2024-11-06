local is_windows = require("radlinskii.utils.system").is_windows()
local path_separator = is_windows and "\\" or "/"

---@class PathUtils
---@field exists fun(filename: string): boolean
---@field join function(paths: ...): string
local M = {
    separator = path_separator,
    exists = function(filename)
        local stat = vim.loop.fs_stat(filename)
        return stat ~= nil
    end,
    join = function(...)
        return table.concat(vim.tbl_flatten({ ... }), path_separator):gsub(path_separator .. "+", path_separator)
    end,
}

return M
