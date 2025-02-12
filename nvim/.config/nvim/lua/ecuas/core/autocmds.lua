local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local opt = vim.opt -- vim options
-- tabs & indentation
-- Set tabstop to 8 for C, C++, and header files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h" },
    callback = function()
        vim.schedule(function()
            opt.tabstop = 4
            opt.shiftwidth = 4
            opt.softtabstop = 4
        end)
    end,
})

-- Format code with clang-format on save without losing cursor position
autocmd("BufWritePre", {
    pattern = {
        -- "*.c",
        -- "*.cpp",
        -- "*.hpp",
        -- "*.h",
        "*.lua",
        "*.md",
        "*.S",
        "*.s"
    },
    callback = function()
        require("ecuas.core.utils").format(vim.lsp.buf.format, {})
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

-- Set tabstop to 4 for all other files
vim.api.nvim_create_autocmd("FileType", {
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

local ecuasGroup = augroup('ecuas', {})
-- set keymaps when lsp attaches.
-- autocmd('LspAttach', {
--     group = ecuasGroup,
--     callback = function(e)
-- vim.keymap.set("n", "K",
--     function()
--         vim.lsp.buf.hover()
--     end,
--     { desc = "Description of current word.", buffer = e.buf }
-- )
--
-- vim.keymap.set("n", "]d",
--     function()
--         vim.diagnostic.goto_next()
--     end,
--     { desc = "Go to next diagnostic.", buffer = e.buf }
-- )
--
-- vim.keymap.set("n", "[d",
--     function()
--         vim.diagnostic.goto_prev()
--     end,
--     { desc = "Go to previous diagnostic.", buffer = e.buf }
-- )
--
-- vim.keymap.set("n", "<leader>gr",
--     function()
--         vim.lsp.buf.rename()
--     end,
--     { desc = "Rename current object throughout entire project.", buffer = e.buf }
-- )
--
-- vim.keymap.set("n", "<leader>gd",
--     function()
--         vim.lsp.buf.declaration()
--         vim.cmd("normal! zt")
--     end,
--     { desc = "Go to object's declaration.", buffer = e.buf }
-- )
--
-- vim.keymap.set("n", "<leader>gi",
--     function()
--         vim.lsp.buf.definition()
--         vim.cmd("normal! zt")
--     end,
--     { desc = "Go to object's definition.", buffer = e.buf }
-- )
--
-- vim.keymap.set("n", "<leader>.",
--     function()
--         vim.lsp.buf.code_action()
--     end,
--     { desc = "Code Action, such as fix." }
-- )
--
-- vim.cmd [[mode]]

-- In telescope.lua:
-- vim.keymap.set('n', '<leader>gs', builtin.lsp_references, { desc = "Telescope References" })
-- vim.keymap.set('n', '<leader>gS', builtin.lsp_document_symbols, { desc = "Telescope Symbols" })
--     end,
-- })

return M
