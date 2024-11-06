local M = {}

-- Function to remove duplicates from a list
M.remove_duplicates = function(input_list)
    local seen = {}
    local unique_list = {}

    for _, value in ipairs(input_list) do
        if not seen[value] then
            seen[value] = true
            table.insert(unique_list, value)
        end
    end

    return unique_list
end

return M
