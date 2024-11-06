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

local function add_words_to_cspell_config(current_buffer)
    local cspell_config_path = require("radlinskii.utils.cspell").find_json()
    local target = current_buffer and vim.api.nvim_buf_get_name(0) or "."
    local words = vim.fn.system("cspell lint --quiet --words-only " .. target)

    local cspell_file = vim.fn.readfile(cspell_config_path)
    local cspell_file_str = table.concat(cspell_file, "\n")

    local success, json = pcall(vim.json.decode, cspell_file_str)

    -- Failed to decode
    if not success or not json then
        print("Error decoding the cspell config json file")

        return
    end

    for word in string.gmatch(words, "(.-)\n") do
        table.insert(json.words, word)
    end

    json.words = require("radlinskii.utils.table").remove_duplicates(json.words)

    table.sort(json.words)

    local jsonString = vim.fn.json_encode(json)

    -- Convert the JSON string to a table of lines
    local jsonLines = { jsonString }

    local result = vim.fn.writefile(jsonLines, cspell_config_path)

    if result == 0 then
        print("Successfully wrote cspell words to:\n" .. cspell_config_path)
    else
        print("Failed to write cspell words to:\n" .. cspell_config_path)
    end
end

usercmd("CSpellAddCurrentWordsToCSpellConfig", function()
    add_words_to_cspell_config(true)
end, { nargs = 0, desc = "Add words found by cspell in the current buffer to cspell config" })

usercmd("CSpellAddAllWordsToCSpellConfig", function()
    add_words_to_cspell_config(true)
end, { nargs = 0, desc = "Add all words found by cspell in CWD to cspell config" })
