require("radlinskii.core.keymaps")
require("radlinskii.core.options")
require("radlinskii.core.autocmds")

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
