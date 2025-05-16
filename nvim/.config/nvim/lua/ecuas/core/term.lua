vim.keymap.set('n', '<c-t>', function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
    vim.cmd.startinsert()
end)

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.wo.statuscolumn = ""
        vim.wo.number = false
        vim.wo.relativenumber = false
    end
})

vim.keymap.set('t', '<c-t>', '<c-d>')
