return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sharkdp/fd",
        "BurntSushi/ripgrep",
        "folke/todo-comments.nvim",
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "%.png",
                    "%.jpg",
                    "%.pdf",
                    ".gitignore",
                    "/obj/",
                    "/bin/",
                },
                layout_strategy = 'vertical',
                layout_config = {
                    height = 0.95,
                },
                path_display = {
                    "smart"
                },
                mappings = {
                    i = {
                        ["<ESC>"] = actions.close,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,

                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,

                        ["<C-/>"] = actions.which_key,
                    },
                }
            },
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy Find" })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Fuzzy Git" })

        vim.keymap.set('v', '<leader>fs', function()
            local reg_unnamed = vim.fn.getreg('""')
            vim.cmd('normal! "zy')
            local selected_text = vim.fn.getreg('z')
            vim.fn.setreg('""', reg_unnamed)
            builtin.grep_string({ search = selected_text })
        end, {desc = "Fuzzy Current Selected Text"})

        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Search > ") })
        end, {desc = "Fuzzy Search" })

        vim.keymap.set('n', '<leader>fh', builtin.search_history, { desc = "Telescope Search History" })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Fuzzy find recent files" })
        vim.keymap.set('n', '<leader>ft', builtin.tags, { desc = "Telescope tags" })
        vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = "Telescope jumplist" })
    end
}
