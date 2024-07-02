local git_ignored = setmetatable({}, {
    __index = function(self, key)
        local proc = vim.system({ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" }, {
            cwd = key,
            text = true,
        })
        local result = proc:wait()
        local ret = {}
        if result.code == 0 then
            for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
                -- Remove trailing slash
                line = line:gsub("/$", "")
                table.insert(ret, line)
            end
        end

        rawset(self, key, ret)
        return ret
    end,
})

---@type LazyPluginSpec
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/which-key.nvim" },
    keys = { { "<leader>o", "<cmd>Oil --float<cr>", desc = "Open Oil directory explorer" } },
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        lsp_file_methods = {
            -- Time to wait for LSP file operations to complete before skipping
            timeout_ms = 2000,
            -- Set to true to autosave buffers that are updated with LSP willRenameFiles
            -- Set to "unmodified" to only save unmodified buffers
            autosave_changes = true,
        },
        keymaps = {
            ["<C-_>"] = { "actions.select", opts = { vertical = true }, desc = "Open in a vertical split" },
            ["<C-/>"] = { "actions.select", opts = { vertical = true }, desc = "Open in a vertical split" },
            ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in a horizontal split" },
            ["<C-c>"] = "actions.close",
            ["<C-s>"] = {
                callback = function()
                    vim.cmd("write")
                end,
                desc = "",
                mode = "n",
            },
        },
        float = {
            padding = 2,
            max_width = 90,
            max_height = 0,
        },
        win_options = {
            wrap = true,
            winblend = 0,
        },
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                -- return name == ".." or name == ".git"
                return name == ".."
            end,
            is_hidden_file = function(name, _)
                -- dotfiles are always considered hidden
                if vim.startswith(name, ".") then
                    return true
                end
                local dir = require("oil").get_current_dir()
                -- if no local directory (e.g. for ssh connections), always show
                if not dir then
                    return false
                end
                -- Check if file is gitignored
                return vim.list_contains(git_ignored[dir], name)
            end,
        },
    },
}
