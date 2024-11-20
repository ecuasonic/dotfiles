return {
    "nvzone/timerly",
    dependencies = {
        "nvzone/volt",
    },
    cmd = "TimerlyToggle",
    visible = false,
    volt_set = false,
    timer = vim.uv.new_timer(),
    clock = nil,
    xpad = 3,
    progress = 0,
    mode = "focus",
    minutes = 10,
    h = 14,
    config = {
        minutes = { 45, 5 },
        on_finish = function()
            vim.notify "Timerly: time's up!"
        end,
        mapping = function()
            local state = require "timerly.state"
            local map = vim.keymap.set
            local myapi = require "timerly.api"
            map("n", "m", myapi.togglemode, { buffer = state.buf })
            map("n", "<cr>", myapi.togglestatus, { buffer = state.buf })
            map("n", "k", myapi.increment, { buffer = state.buf })
            map("n", "j", myapi.decrement, { buffer = state.buf })
            map("n", "<BS>", myapi.reset, { buffer = state.buf })
            map("n", "<esc>", "<cmd>TimerlyToggle<CR>", { buffer = state.buf })
        end,
    },
    status = "",     -- or pause
}
