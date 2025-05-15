local M = {}

function M.run_command_if_changed(path, args, filename)
    local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local buffer_contents = table.concat(buffer_lines, "\n")

    local command = path .. " " .. args .. " " .. filename

    local handle = io.popen(command .. " 2>&1")
    local command_output = handle and handle:read("*all")
    local success = handle and handle:close();

    if not success then
        vim.api.nvim_err_writeln("Error running command: " .. command_output)
        return
    end

    -- Remove trailing newline from the command output
    if command_output:sub(-1) == "\n" then
        command_output = command_output:sub(1, -2)
    end

    if buffer_contents ~= command_output then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(command_output, "\n"))
    end
end

function M.run_command_if_no_errors(path, args, filename)
    local diagnostics = vim.diagnostic.get(0)
    local has_errors = false

    for _, diagnostics in ipairs(diagnostics) do
        if diagnostics.severity == vim.diagnostic.severity.ERROR then
            has_errors = true
            break
        end
    end

    if has_errors then
        vim.api.nvim_err_writeln("Cannot run command: Fix errors in the buffer first.")
        return
    end

    M.run_command_if_changed(path, args, filename)
end

function M.format(func, args, whitespace_only)
    local function trim_trailing_whitespace()
        vim.cmd([[%s/\s\+$//e]])
    end

    -- pos = (row, col)
    -- table indices start at 1!!
    -- stores old cursor position.
    local pos = vim.api.nvim_win_get_cursor(0) -- Save cursor position
    local old_row = pos[1]
    local old_col = pos[2]

    -- format file.
    if (not whitespace_only) then
        func(args);
    end

    trim_trailing_whitespace()

    -- restore old cursor position
    local lines = vim.api.nvim_buf_line_count(0)
    if (lines < old_row) then
        vim.api.nvim_win_set_cursor(0, { lines, old_col })
    else
        vim.api.nvim_win_set_cursor(0, pos)
    end
end

return M
