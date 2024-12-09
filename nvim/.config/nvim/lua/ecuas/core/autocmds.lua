local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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

local ecuasGroup = augroup('ecuas', {})
-- remove whitespace in file.
autocmd({ "BufWritePre" }, {
    group = ecuasGroup,
    pattern = "*",
    callback = function()
        -- save current position
        local pos = vim.api.nvim_win_get_cursor(0)

        vim.cmd([[%s/\s\+$//e]])

        -- restore cursor position
        vim.api.nvim_win_set_cursor(0, pos)
    end
})

-- set keymaps when lsp attaches.
autocmd('LspAttach', {
    group = ecuasGroup,
    callback = function(e)
        vim.keymap.set("n", "K",
            function()
                vim.lsp.buf.hover()
            end,
            { desc = "Description of current word.", buffer = e.buf }
        )

        vim.keymap.set("n", "]d",
            function()
                vim.diagnostic.goto_next()
            end,
            { desc = "Go to next diagnostic.", buffer = e.buf }
        )

        vim.keymap.set("n", "[d",
            function()
                vim.diagnostic.goto_prev()
            end,
            { desc = "Go to previous diagnostic.", buffer = e.buf }
        )

        vim.keymap.set("n", "<leader>gr",
            function()
                vim.lsp.buf.rename()
            end,
            { desc = "Rename current object throughout entire project.", buffer = e.buf }
        )

        vim.keymap.set("n", "<leader>gd",
            function()
                vim.lsp.buf.declaration()
                vim.cmd("normal! zt")
            end,
            { desc = "Go to object's declaration.", buffer = e.buf }
        )

        vim.keymap.set("n", "<leader>gi",
            function()
                vim.lsp.buf.definition()
                vim.cmd("normal! zt")
            end,
            { desc = "Go to object's implementation.", buffer = e.buf }
        )

        vim.keymap.set("n", "<leader>.",
            function()
                vim.lsp.buf.code_action()
            end,
            { desc = "Code Action, such as fix." }
        )

        -- In telescope.lua:
        -- vim.keymap.set('n', '<leader>gs', builtin.lsp_references, { desc = "Telescope References" })
        -- vim.keymap.set('n', '<leader>gS', builtin.lsp_document_symbols, { desc = "Telescope Symbols" })
    end,
})

-- Format code with clang-format on save without losing cursor position
autocmd("BufWritePre", {
    pattern = { "*.c", "*.cpp", "*.h" },
    callback = function()
        local pos = vim.api.nvim_win_get_cursor(0) -- Save cursor position
        vim.cmd("silent! undojoin | silent! %!clang-format")
        vim.api.nvim_win_set_cursor(0, pos)        -- Restore cursor position
    end
})

autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "c" and vim.bo.filetype ~= "cpp" and vim.bo.filetype ~= "h" then
            vim.lsp.buf.format()
        end
    end
})
