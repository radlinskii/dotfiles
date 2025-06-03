---@type LazyPluginSpec
return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
    config = function()
        local is_windows = require("radlinskii.utils.system").is_windows()

        vim.g.lazygit_floating_window_scaling_factor = 0.93
        vim.g.lazygit_floating_window_use_plenary = 0

        if is_windows == false then
            vim.g.lazygit_config_file_path = "~/.config/lazygit/config.yml"
        end
    end,
}
