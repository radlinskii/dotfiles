local M = {}

local config_file_name = ".cspell.json"

M.find_json = function()
    local path = require("radlinskii.utils.path")
    local cwd = vim.fn.getcwd()
    local workspace_cspell_json_file_path = path.join(cwd, config_file_name)
    local global_cspell_json_file_path = path.join(vim.loop.os_homedir(), config_file_name)

    if vim.fn.filereadable(workspace_cspell_json_file_path) == 1 then
        return workspace_cspell_json_file_path
    elseif vim.fn.filereadable(global_cspell_json_file_path) == 1 then
        return global_cspell_json_file_path
    end
end

return M
