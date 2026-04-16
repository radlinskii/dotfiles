vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/kdheepak/lazygit.nvim",
})

local is_windows = require("radlinskii.utils.system").is_windows()

vim.g.lazygit_floating_window_scaling_factor = 0.93
vim.g.lazygit_floating_window_use_plenary = 0

if is_windows == false then
    vim.g.lazygit_config_file_path = "~/.config/lazygit/config.yml"
end

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
