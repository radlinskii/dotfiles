local M = {}

function M.tabline()
    local tabs = {}

    for i = 1, vim.fn.tabpagenr("$") do
        local win_nr = vim.fn.tabpagewinnr(i)
        local buf_list = vim.fn.tabpagebuflist(i)
        local buf_nr = buf_list[win_nr]
        local buf_name = vim.fn.fnamemodify(vim.fn.bufname(buf_nr), ":t")
        local buf_modified = vim.fn.getbufvar(buf_nr, "&mod") == 1
        local tabpage_nr = vim.fn.tabpagenr()

        local is_selected = i == tabpage_nr

        local tab_highlight = is_selected and "%#TabLineSel#" or "%#TabLine#"
        local tab_text_prefix = " " .. i .. (vim.fn.empty(buf_name) == 1 and " [No Name]" or " ")

        table.insert(tabs, tab_highlight .. tab_text_prefix .. buf_name .. " " .. (buf_modified and "+  " or " "))
        table.insert(tabs, "%#TabLineFill#")
    end

    return table.concat(tabs, "")
end

vim.o.tabline = '%!v:lua.require("radlinskii.core.tabline").tabline()'

return M
