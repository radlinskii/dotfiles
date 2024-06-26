return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    init = function()
        vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 1
        vim.g.lazygit_floating_window_use_plenary = 1
    end,
}
