return {
    "Shatur/neovim-session-manager",
    enabled = true,
    config = function()
        local config = require("session_manager.config")

        require("session_manager").setup({
            autoload_mode = config.AutoloadMode.CurrentDir,
        })
    end,
}