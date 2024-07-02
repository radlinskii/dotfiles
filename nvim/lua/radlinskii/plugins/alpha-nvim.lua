---@type LazyPluginSpec
return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        local function footer()
            local version = vim.version()
            local nvim_version_info = "v" .. version.major .. "." .. version.minor .. "." .. version.patch

            return nvim_version_info
        end

        local logo = {
            [[       ___           ___           ___                                    ___       ]],
            [[      /__/\         /  /\         /  /\          ___        ___          /__/\      ]],
            [[      \  \:\       /  /:/_       /  /::\        /__/\      /  /\        |  |::\     ]],
            [[       \  \:\     /  /:/ /\     /  /:/\:\       \  \:\    /  /:/        |  |:|:\    ]],
            [[   _____\__\:\   /  /:/ /:/_   /  /:/  \:\       \  \:\  /__/::\      __|__|:|\:\   ]],
            [[  /__/::::::::\ /__/:/ /:/ /\ /__/:/ \__\:\  ___  \__\:\ \__\/\:\__  /__/::::| \:\  ]],
            [[  \  \:\‾‾\‾‾\/ \  \:\/:/ /:/ \  \:\ /  /:/ /__/\ |  |:|    \  \:\/\ \  \:\‾‾\__\/  ]],
            [[   \  \:\  ‾‾‾   \  \::/ /:/   \  \:\  /:/  \  \:\|  |:|     \__\::/  \  \:\        ]],
            [[    \  \:\        \  \:\/:/     \  \:\/:/    \  \:\__|:|     /__/:/    \  \:\       ]],
            [[     \  \:\        \  \::/       \  \::/      \__\::::/      \__\/      \  \:\      ]],
            [[      \__\/         \__\/         \__\/           ‾‾‾                    \__\/      ]],
            [[                                                                                    ]],
            [[                                                                                    ]],
            [[                                                                                    ]],
            [[                                                                                    ]],
            [[                                                                                    ]],
        }

        dashboard.section.header.val = logo
        dashboard.section.header.opts.hl = "String"

        dashboard.section.buttons.val = {
            dashboard.button(
                "<Space>fo",
                "󰙰    Local Recent Files",
                "<cmd>lua require('telescope.builtin').oldfiles({cwd_only = true})<CR>"
            ),
            dashboard.button(
                "<Space>fO",
                "󰝉    Recent Files ",
                "<cmd>lua require('telescope.builtin').oldfiles({cwd_only = false})<CR>"
            ),
            dashboard.button(
                "<Space>ff",
                "    Find File ",
                "<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--follow', '-g', '!.git', '--hidden' }})<CR>"
            ),
            dashboard.button("<Space>fs", "󰈭    Find Word ", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("<Space>fgs", "    Git Status", "<cmd>Telescope git_status<CR>"),
            dashboard.button("<Space>fm", "    Bookmarks ", "<cmd>Telescope marks<CR>"),
            dashboard.button("<Space>fh", "󰮥    Help ", "<cmd>Telescope help_tags<CR>"),
            dashboard.button("q", "✖    Quit", ":qa<cr>"),
        }

        dashboard.section.footer.val = footer()
        dashboard.section.footer.opts.hl = "Constant"

        alpha.setup(dashboard.opts)

        vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
    end,
}
