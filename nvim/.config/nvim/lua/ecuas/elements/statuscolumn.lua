local M = {}

-- set highlight and number value for current line and non-current lines.
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

-- convert table into string
M.statuscol = function()
    local text = ""
    text = table.concat({
        "%s",
        M.numbers(),
    })
    return text
end

-- set statuscolumn
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%!v:lua.require('ecuas.elements.statuscolumn').statuscol()";

return M
