M = {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'kkharji/sqlite.lua'
    },
    config = function()
        require('neoclip').setup({
            history = 500,
            layout_strategy = 'horizontal',
            enable_persistent_history = true,
            length_limit = 10000,
            continuous_sync = true,
            db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
            filter = nil,
            preview = true,
            prompt = "> ",
            default_register = '"',
            default_register_macros = 'q',
            enable_macro_history = true,
            content_spec_column = false,
            disable_keycodes_parsing = false,
            on_select = {
                move_to_front = false,
                close_telescope = true,
            },
            on_paste = {
                set_reg = false,
                move_to_front = false,
                close_telescope = true,
            },
            on_replay = {
                set_reg = false,
                move_to_front = false,
                close_telescope = true,
            },
            on_custom_action = {
                close_telescope = true,
            },
            keys = {
                telescope = {
                    i = {
                        select = '<cr>',
                        paste = '<c-p>',
                        paste_behind = '<c-`>',
                        replay = '<c-q>', -- replay a macro
                        delete = '<c-d>', -- delete an entry
                        edit = '<c-e>',   -- edit an entry
                        custom = {},
                    },
                },
            },
        })
    end,
}

-- return {}
return M
