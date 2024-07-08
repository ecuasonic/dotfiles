-- core setup
require("ecuas.core.plugin-manager")
require("ecuas.core.options")
require("ecuas.core.remap")
require("ecuas.core.config")

-- load plugins
require("ecuas.plugins-setup")

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
            timeout = 40,
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
        vim.keymap.set("n", "<c-d>", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "d]", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "d[", function() vim.diagnostic.goto_prev() end, opts)
        -- vim.keymap.set("n", "gd", function() vim.lsp.buf.defintion() end, opts)
        -- vim.keymap.set("n", "<C-s>", function() vim.lsp.buf.signature_help() end, opts)
        -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        -- vim.keymap.set("n", "<c-d>", function() vim.diagnostic.open_float() end, opts)
        -- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.reference() end, opts)
        -- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.renamedefintiondefintion() end, opts)
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
