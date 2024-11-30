-- require lazy in safety mode
local status, lazy = pcall(require, "lazy")
if not status then
    return vim.notify("lazy is not installed.")
end

vim.g.mapleader = " "

lazy.setup({
    { import = "ecuas.plugins" },
    { import = "ecuas.plugins.looks" },
    { import = "ecuas.plugins.keys" },
    { import = "ecuas.plugins.keys.telescope" },
    { import = "ecuas.plugins.commands" },
}, {
    -- options
    ui = {
        border = "single",
    },
    change_detection = { notify = false }
})
