local M = {}

local function extract_balanced_parens(text, start_pos)
    local pos = start_pos or 1
    local open_pos = text:find("%(", pos)
    if not open_pos then return nil end

    local depth = 1
    local i = open_pos + 1
    while i <= #text do
        local c = text:sub(i, i)
        if c == "(" then
            depth = depth + 1
        elseif c == ")" then
            depth = depth - 1
            if depth == 0 then
                return text:sub(open_pos + 1, i - 1), i
            end
        end
        i = i + 1
    end
    return nil -- no matching closing paren found
end

function M.generate_instance_from_selection()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    local start_line = start_pos[2] - 1
    local end_line = end_pos[2]

    -- Get lines from visual selection
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
    local text = table.concat(lines, "\n")

    -- Extract module name, parameter block and port block
    local module_name = text:match("module%s+([%w_]+)%s*.*")

    local param_block = nil
    local port_block = nil

    if text:find("#%(") then
        param_block, end_pos = extract_balanced_parens(text, nil)
        port_block, end_pos = extract_balanced_parens(text, end_pos)
    else
        port_block, end_pos = extract_balanced_parens(text, nil)
    end

    if not module_name then
        print("Module name not found.")
        return
    end

    -- Parse params
    local params = {}
    if param_block then
        for line in param_block:gmatch("[^\n,]+") do
            -- Try matching parameter with default value
            local name = line:match("parameter%s+[%w_%[%]:]*%s+([%w_]+)%s*=")
            -- If not matched, try parameter without value
            if not name then
                name = line:match("parameter%s+[%w_%[%]:]*%s+([%w_]+)%s*$")
            end
            if name then
                table.insert(params, name)
            end
        end
    end

    -- Parse ports
    local ports = {}
    if port_block then
        for line in port_block:gmatch("[^,]+") do
            local name = line:match("([%w_]+)%s*$")
            if name then
                table.insert(ports, name)
            end
        end
    end

    -- Generate instantiation block
    local inst = {}
    if #params > 0 then
        table.insert(inst, module_name .. " #(")
        for i, p in ipairs(params) do
            table.insert(inst, string.format("    .%s()", p) .. (i ~= #params and "," or ""))
        end
        table.insert(inst, ") name (")
    else
        table.insert(inst, module_name .. " name (")
    end
    for i, port in ipairs(ports) do
        table.insert(inst, string.format("    .%s()", port) .. (i ~= #ports and "," or ""))
    end
    table.insert(inst, ");")

    vim.fn.setreg('"', table.concat(inst, "\n"))
end

return M

