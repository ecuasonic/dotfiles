-- require lazy in safety mode
local status, lazy = pcall(require, "lazy")
if not status then
    return vim.notify("lazy is not installed.")
end

vim.g.mapleader = " "

lazy.setup({
    { import = "ecuas.plugins.commands" },
    { import = "ecuas.plugins.keys" },
    { import = "ecuas.plugins.looks" },
    { import = "ecuas.plugins.local" },
    { import = "ecuas.plugins.foundation.lsp" },
    { import = "ecuas.plugins.foundation.telescope" },
    { import = "ecuas.plugins.foundation.treesitter" },
}, {
    -- options
    ui = {
        border = "single",
    },
    change_detection = { notify = false }
})
