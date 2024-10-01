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
        local z_utils = require("telescope._extensions.zoxide.utils")
        local builtin = require('telescope.builtin')

        telescope.setup({
            extensions = {
                zoxide = {
                    prompt_title = "[ Zoxide List ]",
                    list_command = "zoxide query -ls",
                    mappings = {
                        default = {
                            action = function(selection)
                                vim.cmd.cd(selection.path)
                            end,
                            after_action = function(selection)
                                vim.notify("Directory changed to " .. selection.path)
                            end,
                        },
                        ["<C-f>"] = {
                            keepinsert = true,
                            action = function(selection)
                                builtin.find_files({ cwd = selection.path })
                            end,
                        }
                    }
                }
            },
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                file_ignore_patterns = {
                    "%.png",
                    "%.jpg",
                    "%.pdf",
                    ".gitignore",
                    "%/obj/%",
                    "%/bin/%",
                },
                color_devicons = false,
                selection_caret = ' ',
                sorting_strategy = 'descending',
                selection_strategy = 'row',
                scroll_strategy = 'limit',
                layout_strategy = 'vertical',
                wrap_results = true,
                entry_prefix = '\t',
                initial_mode = 'insert',
                border = true,
                layout_config = {
                    height = 0.95,
                },
                path_display = { shorten_path = 15 },
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

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy Find" })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Fuzzy Git" })

        vim.keymap.set('v', '<leader>fs', function()
            local reg_unnamed = vim.fn.getreg('""')
            vim.cmd('normal! "zy')
            local selected_text = vim.fn.getreg('z')
            vim.fn.setreg('""', reg_unnamed)
            builtin.grep_string({ search = selected_text })
        end, {desc = "Fuzzy Current Selected Text"})

        vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = "Fuzzy Text"})
        vim.keymap.set('n', '<leader>fh', builtin.search_history, { desc = "Telescope Search History" })
        vim.keymap.set('n', '<leader>ft', builtin.tags, { desc = "Telescope tags" })
        vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = "Telescope jumplist" })
        vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "Telescope References" })
        vim.keymap.set('n', 'ge', builtin.lsp_document_symbols, { desc = "Telescope Symbols" })

        telescope.load_extension('zoxide')
        vim.keymap.set('n', '<leader>cd', telescope.extensions.zoxide.list)
        vim.keymap.set('n', '<leader>fc', ":Telescope neoclip<CR>", { desc = "Telescope Symbols" })
    end
}
