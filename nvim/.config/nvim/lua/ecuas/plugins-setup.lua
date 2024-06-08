-- require lazy in safety mode
local status, lazy = pcall(require, "lazy")
if not status then
  return vim.notify("lazy is not installed.")
end

vim.g.mapleader = " "

lazy.setup({
    { import = "ecuas.plugins" }
}, {
    -- options
    ui = {
        border = "single",
    },
        change_detection = { notify = false }
})
