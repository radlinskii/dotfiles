local usercmd = vim.api.nvim_create_user_command

usercmd("ClearShada", function()
    -- tested only on Windows
    local shada_path = vim.fn.expand(vim.fn.stdpath("data") .. "/shada")
    local files = vim.fn.glob(shada_path .. "/*", false, true)
    local all_success = 0

    for _, file in ipairs(files) do
        local file_name = vim.fn.fnamemodify(file, ":t")
        if file_name == "main.shada" then
            -- skip your main.shada file
            goto continue
        end
        local success = vim.fn.delete(file)
        all_success = all_success + success
        if success ~= 0 then
            vim.notify("Couldn't delete file '" .. file_name .. "'", vim.log.levels.WARN)
        end
        ::continue::
    end
    if all_success == 0 then
        vim.print("Successfully deleted all temporary shada files")
    end
end, { desc = "Clears all the .tmp shada files" })

usercmd("ReopenInLastTabAtLine", function(opts)
    local line_number = opts.args:match("^(%d+)%s+")
    local filename = opts.args:match('%"([^%"]+)%"')
    if line_number and filename then
        vim.cmd("bdelete")
        vim.cmd("edit " .. filename)
        vim.cmd(line_number)
    else
        print('Usage: ReopenInLastTabAtLine <line_number> "<filename>"')
    end
end, { nargs = 1, complete = "file", desc = "Used by lazygit to open hunks, tested on Windows" })

usercmd("ReopenInLastTab", function(opts)
    local filename = opts.args:match('%"([^%"]+)%"')
    if filename then
        vim.cmd("bdelete")
        vim.cmd("edit " .. filename)
    else
        print('Usage: ReopenInLastTab "<filename>"')
    end
end, { nargs = 1, complete = "file", desc = "Used by lazygit to open hunks, tested on Windows" })
