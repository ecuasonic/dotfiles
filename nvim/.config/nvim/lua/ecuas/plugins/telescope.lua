vim.api.nvim_create_autocmd("Filetype", {
    pattern = "TelescopeResults",
    callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("text", "^.*:[0-9]*:[0-9]*:")
            vim.fn.matchadd("text", '[^:\\[\\]\\(\\) ]*/')
            vim.api.nvim_set_hl(0, "text", { fg = "#404040" })
        end)
    end,
})

local function live_grep_change(_, path)
    local tail = vim.fs.basename(path)
    local parent = vim.fs.dirname(path)
    if parent == "." then
        return tail
    else
        return string.format("%s/%s", parent, tail)
    end
    return path
end

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
                    "%/obj/%",
                    "%/bin/%",
                },
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
                path_display = {
                    shorten = 7
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

        vim.keymap.set('n', '<leader>fs', builtin.live_grep)
        vim.keymap.set('n', '<leader>fh', builtin.search_history, { desc = "Telescope Search History" })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Fuzzy find recent files" })
        vim.keymap.set('n', '<leader>ft', builtin.tags, { desc = "Telescope tags" })
        vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = "Telescope jumplist" })
    end
}
