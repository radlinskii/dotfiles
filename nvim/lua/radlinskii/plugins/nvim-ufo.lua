return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
        {
            "luukvbaal/statuscol.nvim",
            config = function()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup({
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                        { text = { "%s" }, click = "v:lua.ScSa" },
                        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    },
                })
            end,
        },
    },
    event = "BufRead",
    config = function()
        vim.opt.foldcolumn = "1"
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldenable = true
        vim.opt.fillchars:append({
            eob = " ",
            fold = " ",
            foldopen = "▼",
            foldsep = " ",
            foldclose = "⏵",
        })

        local handler = function(virtualText, lineNum, endLineNum, width, truncate)
            local newVirtText = {}
            local totalLines = vim.api.nvim_buf_line_count(0)
            local foldedLines = endLineNum - lineNum
            local suffix = ("    ... ↙ %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtualText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            local rightAlignAppendix =
                math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
            suffix = (" "):rep(rightAlignAppendix) .. suffix
            table.insert(newVirtText, { suffix, "MoreMsg" })
            return newVirtText
        end

        require("ufo").setup({
            -- close_fold_kinds = { "imports" },
            fold_virt_text_handler = handler,
        })

        vim.keymap.set("n", "zR", function()
            require("ufo").openAllFolds()
        end, { desc = "Open all folds", noremap = true, silent = true })

        vim.keymap.set("n", "zM", function()
            require("ufo").closeAllFolds()
        end, { desc = "Fold all folds", noremap = true, silent = true })

        vim.keymap.set("n", "[z", function()
            require("ufo").goPreviousStartFold()
        end, { desc = "Move to start of previous fold", noremap = true, silent = true })

        vim.keymap.set("n", "[w", function()
            require("ufo").goPreviousClosedFold()
        end, { desc = "Move to previous closed fold", noremap = true, silent = true })

        vim.keymap.set("n", "]w", function()
            require("ufo").goNextClosedFold()
        end, { desc = "Move to next closed fold", noremap = true, silent = true })

        vim.keymap.set("n", "zh", function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end, { desc = "Peek folded lines under current cursor", noremap = true, silent = true })
    end,
}
