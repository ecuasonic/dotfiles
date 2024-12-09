local M = {}

vim.opt.signcolumn = "yes"

M.numbers = function()
    local text = ""

    if vim.v.virtnum == 0 then
        if vim.v.relnum == 0 then
            text = text .. "%=%#CustomLineNr# " .. string.format("%4s", vim.v.lnum) .. " %* "
        else
            text = text .. "%=%#White# " .. string.format("%4s", vim.v.relnum) .. " %* "
        end
    end

    return text
end

M.statuscol = function()
    local text = ""
    text = table.concat({
        " %s",
        M.numbers(),
    })
    return text
end

return M
