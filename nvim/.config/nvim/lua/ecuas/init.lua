-- core setup
require("ecuas.core.plugin-manager")
require("ecuas.core.options")
require("ecuas.core.remap")
require("ecuas.core.config")

-- load plugins
require("ecuas.plugins-setup")

-- vim.o.path = vim.o.path .. "/usr/avr/include,/home/ecuas/.arduino15/,/usr/lib/gcc/avr/14.1.0/include,/usr/lib/gcc/avr/14.1.0/include-fixed"

local augroup = vim.api.nvim_create_augroup
local ecuasGroup = augroup('ecuas', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
        require("plenary.reload").reload_module(name)
end

vim.filetype.add({
        extension = {
                templ = 'templ'
        }
})

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
autocmd({"BufWritePre"}, {
        group = ecuasGroup,
        pattern = "*",
        command = [[%s/\s\+$//e]],
})
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
                        { desc = "Code Action, such as fix."}
                )

                -- In telescope.lua:
                -- vim.keymap.set('n', '<leader>gs', builtin.lsp_references, { desc = "Telescope References" })
                -- vim.keymap.set('n', '<leader>gS', builtin.lsp_document_symbols, { desc = "Telescope Symbols" })
        end,
})

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
                border = _border
        }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
                border = _border
        }
)

vim.diagnostic.config{
        float={border=_border}
}

require('lspconfig.ui.windows').default_options = {
        border = _border
}

-- vim.cmd([[highlight ColorColumn ctermbg=235 guibg=#383c44]])
vim.cmd([[hi Comment guifg=yellow guibg=NONE]])
vim.cmd([[hi RenderMarkdownCodeInline guifg=#FFC133 guibg=NONE]])
vim.cmd([[hi @markup.raw.markdown_inline guifg=#FFC133 guibg=NONE]])
-- vim.cmd [[ autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--         vim.lsp.diagnostic.on_publish_diagnostics, {
--                 virtual_text = false
--         }
-- )
