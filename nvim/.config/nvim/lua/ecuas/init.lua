-- core setup
require("ecuas.core.plugin-manager")
require("ecuas.core.options")
require("ecuas.core.remap")
require("ecuas.core.config")

-- load plugins
require("ecuas.plugins-setup")

vim.o.path = vim.o.path .. "/usr/avr/include,/home/ecuas/.arduino15/,/usr/lib/gcc/avr/14.1.0/include,/usr/lib/gcc/avr/14.1.0/include-fixed"

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

-- vim.cmd([[highlight ColorColumn ctermbg=235 guibg=#383c44]])
vim.cmd([[hi Comment guifg=yellow ctermfg=yellow]])

-----------------ARDUINO------------------

-- Function to set C_INCLUDE_PATH based on directory
local function update_include_path()
    local cwd = vim.fn.getcwd()
    if cwd == vim.fn.expand("~/Arduino") or cwd == vim.fn.expand("/usr/avr/include/*") then
        vim.fn.setenv("C_INCLUDE_PATH", "/usr/avr/include")
        print("C_INCLUDE_PATH set to: /usr/avr/include")
    else
        vim.fn.setenv("C_INCLUDE_PATH", "")
        print("C_INCLUDE_PATH cleared")
    end
end

-- Set an autocommand to trigger the update_include_path function on directory change
vim.api.nvim_create_autocmd("DirChanged", {
    pattern = "*",
    callback = update_include_path
})

-- Call the function on startup to set the correct path initially
update_include_path()
