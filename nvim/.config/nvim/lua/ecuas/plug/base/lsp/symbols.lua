return {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
        { "<leader>E", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
        outline_window = {
            position = 'float',
            width = 40,
            relative_width = false,
            focus_on_open = true,
            show_cursorline = true,
            hide_cursor = true
        },
        keymaps = {
            goto_location = '<NOP>',
            goto_and_close = '<NOP>',
            down_and_jump = '<NOP>',
            up_and_jump = '<NOP>',
            restore_location = '<NOP>',
            fold_toggle = '<NOP>',

            close = { '<Esc>', 'q' },
            fold_toggle_all = '<S-tab>',
            peek_location = '<tab>',
            fold = 'h',
            unfold = 'l',

            show_help = '?',
            hover_symbol = '<C-space>',
            toggle_preview = 'K',
            rename_symbol = 'r',
            code_actions = 'a',
            fold_all = 'W',
            unfold_all = 'E',
            fold_reset = 'R',
        },
    },
}
