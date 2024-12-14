local M = {}

M.get_branch = function()
    return "%#Green#" .. vim.fn["FugitiveHead"]() .. "%#White#"
end

M.get_percentage = function()
    local lines = vim.api.nvim_buf_line_count(0)
    local row = (vim.api.nvim_win_get_cursor(0))[1]
    if (row == 1) then
        return " Top"
    elseif (row == lines) then
        return " Bot"
    end
    return string.format("%3.0f", (row / lines) * 100) .. "%%"
end

return M
