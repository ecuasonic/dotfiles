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
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "d]", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "d[", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.definition() end, opts)
        -- In telescope.lua:
        -- vim.keymap.set('n', 'gs', builtin.lsp_references, { desc = "Telescope References" })
        -- vim.keymap.set('n', 'gS', builtin.lsp_document_symbols, { desc = "Telescope Symbols" })
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
vim.cmd([[hi Comment guifg=yellow ctermfg=yellow]])
