vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "(\\./[^)]*)")
			vim.fn.matchadd("TelescopeParent", "(\\.)")
			vim.api.nvim_set_hl(0, "TelescopeParent", {fg = 'gray'})
            vim.fn.matchadd("Icon", "^[^a-zA-Z0-9]*")
			vim.api.nvim_set_hl(0, "Icon", {fg = 'orange'})
		end)
	end,
})

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
            pickers = {
                lsp_references = {
                    path_display = function(opts, path)
                        local filename = vim.fs.basename(path)
                        local pwd_len = string.len(vim.fn.system('pwd'))
                        local parent = vim.fs.dirname(path)
                        parent = string.sub(parent,pwd_len,-1)
                        return string.format("%s (%s)", filename, '.' .. parent)
                    end,
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
                selection_strategy = 'reset',
                scroll_strategy = 'limit',
                layout_strategy = 'vertical',
                wrap_results = false,
                entry_prefix = '\t',
                initial_mode = 'insert',
                border = true,
                layout_config = {
                    height = 0.95,
                },
                -- Format path as "file.txt (path\to\file\)"
                path_display = function(opts, path)
                    local filename = vim.fs.basename(path)
                    local dirname = vim.fs.dirname(path)
                    if (dirname == '.') then
                        return string.format("%s (.)", filename)
                    else
                        return string.format("%s (%s)", filename, "./" .. dirname)
                    end
                end,
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

        --------------------------------------------------------------------
        -------------- FZF/Grep Functions and Keymaps ----------------------
        --------------------------------------------------------------------
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy Find" })
        vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = "Fuzzy Text"})
        vim.keymap.set('v', '<leader>fs', function()
            local reg_unnamed = vim.fn.getreg('""')
            vim.cmd('normal! "zy')
            local selected_text = vim.fn.getreg('z')
            vim.fn.setreg('""', reg_unnamed)
            builtin.grep_string({ search = selected_text })
        end, {desc = "Fuzzy Current Selected Text"})


        ---------------------------------------------------------------
        -------------- LSP Functions and Keymaps ----------------------
        ---------------------------------------------------------------
        vim.keymap.set('n', '<leader>gs', builtin.lsp_references, { desc = "Telescope References" })
        vim.keymap.set('n', '<leader>ge', builtin.lsp_document_symbols, { desc = "Telescope Symbols" })

        -- In init.lua:
        -- vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.rename() end, opts)
        -- vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.declaration() end, opts)
        -- vim.keymap.set("n", "<leader>gi", function() vim.lsp.buf.definition() end, opts)

        -- In remap.lua:
        -- keymap.set("n", "gf", function()
        --     if require("obsidian").util.cursor_on_markdown_link() then
        --         vim.cmd("normal! m'")
        --         vim.cmd("ObsidianFollowLink")
        --         vim.defer_fn(function()
        --             vim.cmd("normal! zt")  -- Run zt after the link is followed
        --         end, 50)
        --     else
        --         vim.cmd("normal! gf")
        --         vim.cmd("normal! zt")
        --     end
        -- end)


        ------------------------------------------------------------------
        --------------------------- Zoxide -------------------------------
        ------------------------------------------------------------------
        telescope.load_extension('zoxide')
        vim.keymap.set('n', '<leader>cd', telescope.extensions.zoxide.list)
        vim.keymap.set('n', '<leader>fc', ":Telescope neoclip<CR>", { desc = "Telescope Symbols" })
    end
}
