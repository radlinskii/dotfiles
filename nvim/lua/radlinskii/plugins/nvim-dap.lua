local is_windows = require("radlinskii.utils.system").is_windows

local js_based_languages = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
}

local json5BuildScriptPath = "./install.sh"

if is_windows then
    json5BuildScriptPath = "powershell ./install.ps1"
end

-- After install, build it and rename the dist directory to out
local vscodeJSDebugBuildCommand =
    "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out"

-- for windows use different commands for removal and moving
if is_windows then
    -- run the same build command as for other os
    vscodeJSDebugBuildCommand = "npm install --legacy-peer-deps --no-save" .. " && npx gulp vsDebugServerBundle"

    local previousBuildPath = vim.fn.stdpath("data") .. "\\lazy\\vscode-js-debug\\out"
    -- if directory with previous build already exists remove it
    local directoryExistsCmd = 'if exist "' .. previousBuildPath .. '" echo EXISTS'
    local directoryExists = vim.fn.system(directoryExistsCmd) == "EXISTS"

    if directoryExists then
        vscodeJSDebugBuildCommand = vscodeJSDebugBuildCommand .. ' && rmdir /s /q "' .. previousBuildPath .. '"'
    end

    -- move dist folder to out (for some reason)
    vscodeJSDebugBuildCommand = vscodeJSDebugBuildCommand .. " && move dist out"
end

return {
    "rcarriga/nvim-dap-ui",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.after.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.after.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end,
    dependencies = {
        { "nvim-neotest/nvim-nio" },
        {

            "mfussenegger/nvim-dap",
            config = function()
                local dap = require("dap")

                for _, language in ipairs(js_based_languages) do
                    dap.configurations[language] = {
                        -- Debug single nodejs files
                        {
                            name = "Launch file",
                            type = "pwa-node",
                            request = "launch",
                            program = "${file}",
                            cwd = vim.fn.getcwd(),
                            sourceMaps = true,
                        },
                        -- Debug nodejs processes (make sure to add --inspect when you run the process)
                        {
                            name = "Attach node",
                            type = "pwa-node",
                            request = "attach",
                            port = function()
                                local co = coroutine.running()
                                return coroutine.create(function()
                                    vim.ui.input({
                                        prompt = "Enter PORT: ",
                                        default = 5858,
                                    }, function(url)
                                        if url == nil or url == "" then
                                            return
                                        else
                                            coroutine.resume(co, url)
                                        end
                                    end)
                                end)
                            end,
                            localRoot = vim.fn.getcwd(),
                        },
                        -- Debug web applications (client side)
                        -- {
                        --     type = "pwa-chrome",
                        --     request = "attach",
                        --     name = "Electron: Renderer",
                        --     url = function()
                        --         local co = coroutine.running()
                        --         return coroutine.create(function()
                        --             vim.ui.input({
                        --                 prompt = "Enter URL: ",
                        --                 default = "http://localhost:9228",
                        --             }, function(url)
                        --                 if url == nil or url == "" then
                        --                     return
                        --                 else
                        --                     coroutine.resume(co, url)
                        --                 end
                        --             end)
                        --         end)
                        --     end,
                        --     webRoot = vim.fn.getcwd(),
                        --     sourceMaps = true,
                        --     userDataDir = false,
                        --     timeout = 30000,
                        -- },
                        -- Divider for the launch.json derived configs
                        {
                            name = "----- ↓ launch.json configs ↓ -----",
                            type = "",
                            request = "launch",
                        },
                    }
                end

                local wk = require("which-key")
                wk.register({
                    ["<leader>d"] = {
                        name = "Diffview/Debugger",
                    },
                })
                wk.register({
                    ["<leader>db"] = {
                        name = "Debugger",
                    },
                })
            end,
            keys = {
                {
                    "<leader>dbo",
                    function()
                        require("dap").step_out()
                    end,
                    desc = "Step Out",
                    noremap = true,
                    silent = true,
                },
                {
                    "<leader>dbs",
                    function()
                        require("dap").step_over()
                    end,
                    desc = "Step Over",
                    noremap = true,
                    silent = true,
                },
                -- {
                --     "<leader>dba",
                --     function()
                --         if vim.fn.filereadable("../../.vscode/launch.json") then
                --             local dap_vscode = require("dap.ext.vscode")
                --             dap_vscode.load_launchjs(nil, {
                --                 ["pwa-node"] = js_based_languages,
                --                 ["chrome"] = js_based_languages,
                --                 ["pwa-chrome"] = js_based_languages,
                --             })
                --         end
                --         require("dap").continue()
                --     end,
                --     desc = "Run with Args",
                -- noremap = true,
                -- silent = true,
                -- },
                {
                    "<leader>dbb",
                    "<cmd> DapToggleBreakpoint <CR>",
                    desc = "Toggle breakpoint",
                    noremap = true,
                    silent = true,
                },
                {
                    "<leader>dbr",
                    "<cmd> DapContinue <CR>",
                    desc = "Run or continue the debugger",
                    noremap = true,
                    silent = true,
                },
                {
                    "<leader>dbx",
                    "<cmd> DapTerminate <CR>",
                    desc = "Terminate debugger session",
                    noremap = true,
                    silent = true,
                },
            },
            dependencies = {
                -- Install the vscode-js-debug adapter
                {
                    "microsoft/vscode-js-debug",
                    build = vscodeJSDebugBuildCommand,
                    version = "1.*",
                },
                { "folke/which-key.nvim" },
                {
                    "mxsdev/nvim-dap-vscode-js",
                    config = function()
                        require("dap-vscode-js").setup({
                            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
                            -- node_path = "node",

                            -- Path to vscode-js-debug installation.
                            debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

                            -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
                            -- debugger_cmd = { "js-debug-adapter" },

                            -- which adapters to register in nvim-dap
                            adapters = {
                                "chrome",
                                "pwa-node",
                                "pwa-chrome",
                                "pwa-msedge",
                                "pwa-extensionHost",
                                "node-terminal",
                            },

                            -- Path for file logging
                            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

                            -- Logging level for output to file. Set to false to disable logging.
                            -- log_file_level = false,

                            -- Logging level for output to console. Set to false to disable console output.
                            -- log_console_level = vim.log.levels.ERROR,
                        })
                    end,
                },
                {
                    "Joakker/lua-json5",
                    build = json5BuildScriptPath,
                },
            },
        },
    },
}
