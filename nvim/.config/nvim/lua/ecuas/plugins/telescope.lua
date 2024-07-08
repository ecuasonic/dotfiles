return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sharkdp/fd",
        "BurntSushi/ripgrep",
        "folke/todo-comments.nvim",
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local transform_mod = require("telescope.actions.mt").transform_mod

        -- local trouble = require("trouble")
        -- local trouble_telescope = require("trouble.sources.telescope")

        -- or create your custom action
        -- local custom_actions = transform_mod({
        --     open_trouble_qflist = function(prompt_bufnr)
        --         trouble.toggle("quickfix")
        --     end,
        -- })

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            -- ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            -- ["<C-t>"] = trouble_telescope.open,
                    }
                }
            }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy Find" })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Fuzzy Git" })
        vim.keymap.set('n', '<leader>fcw', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "Fuzzy Current Word (within other words)" })

        vim.keymap.set('n', '<leader>fcW', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Fuzzy Current Word (separate from other words)" })

        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, {desc = "Fuzzy Search" })

        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Fuzzy Help Tags" })
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Fuzzy find recent files" })
        vim.keymap.set('n', '<leader>ft', "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    end
}
