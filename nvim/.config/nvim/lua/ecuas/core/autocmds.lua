local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local opt = vim.opt -- vim options
-- tabs & indentation
-- Set tabstop to 8 for C, C++, and header files
autocmd("FileType", {
    pattern = { "c", "cpp", "h" },
    callback = function()
        vim.schedule(function()
            opt.tabstop = 2
            opt.shiftwidth = 2
            opt.softtabstop = 2
        end)
    end,
})

-- Set tabstop to 4 for all other files
autocmd("FileType", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "c"
            and vim.bo.filetype ~= "cpp"
            and vim.bo.filetype ~= "h"
            and vim.bo.filetype ~= "hpp" then
            opt.tabstop = 4
            opt.softtabstop = 4
            opt.shiftwidth = 4
        end
    end,
})

-- For tmux keys in :Ex or netrw.
autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", ":TmuxNavigateRight<CR>", opts)
    end
})


-- Format code with clang-format on save without losing cursor position
autocmd("BufWritePre", {
    pattern = {
        "*.c",
        "*.cpp",
        "*.hpp",
        "*.h",
        "*.lua",
        "*.md",
        "*.S",
        "*.s"
    },
    callback = function()
        require("ecuas.core.utils").format(vim.lsp.buf.format, {}, true)
    end,
})

-- TODO: Set env command if first part is scp
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        if (string.sub(filename, 1, 3) == "scp") then
            vim.env.var = filename
        end
    end,
})


local yank_group = augroup('HighlightYank', {})
-- highlight before yanking.
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 100,
        })
    end,
})


autocmd("BufWritePost", {
    pattern = { "*.v", "*.sv" },
    callback = function()
        local utils = require("ecuas.core.utils")
        utils.format(
            function(args)
                local filename = vim.api.nvim_buf_get_name(0)
                local path = "/home/ecuas/verilog/verible/bin/verible-verilog-format"
                args = table.concat(args)
                utils.run_command_if_no_errors(path, args, filename)
            end,
            {
                -- "--column_limit=100 ",
                "--indentation_spaces=4 "
            }
        )
        -- vim.cmd [[w]]
    end
})

-- Moves window to nearest actual line on VimResized Event.
autocmd("VimResized", {
    callback = function()
        -- Account for winbar and tabline.
        local win_height = vim.api.nvim_win_get_height(0) - 2
        local lines_visible = vim.fn.line('w$') - vim.fn.line('w0')
        if (win_height > lines_visible) then
            vim.cmd [[normal! zb]]
        end
    end
})

return M
