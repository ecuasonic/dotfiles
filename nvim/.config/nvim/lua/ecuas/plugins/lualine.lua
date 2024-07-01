function Harpoon_files()
    local contents = {}
    local marks_length = require("harpoon"):list():length()
    local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
    for index = 1, marks_length do
        local harpoon_file_path = require("harpoon"):list():get(index).value
        local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ':t')

        if current_file_path == harpoon_file_path then
            contents[index] = string.format("%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ", index, file_name)
        else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index, file_name)
        end
        vim.cmd([[highlight HarpoonNumberActive ctermfg=255 guifg=yellow]])
        vim.cmd([[highlight HarpoonActive ctermfg=255 guifg=cyan]])
        vim.cmd([[highlight HarpoonNumberInactive ctermfg=255 guifg=yellow]])
        vim.cmd([[highlight HarpoonInactive ctermfg=255 guifg=white]])

    end

    return table.concat(contents)
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "theprimeagen/harpoon"
    },
    config = function()

        local mode = {
            'mode',
            icons_enabled = true,
            icon = nil,
            separator = '',
            cond = nil,
            draw_empty = false,
            type = nil,
            padding = 1,
            fmt = nil,
            on_click = nil,
        }

        local diagnostics = {
            'diagnostics',
            sources = { 'nvim_lsp' },
            sections = { 'error', 'warn', 'info', 'hint' },
            --diagnostics_color = {
            --error = 'DiagnosticError',
            --warn = 'DiagnosticWarn',
            --info = 'DiagnosticInfo',
            --hint = 'DiagnosticHint',
            --},
            --symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
            colored = true,
            update_in_insert = false,
            always_visible = false,
        }

        local filename = {
            'filename',
            file_status = true,
            newfile_status = false,
            padding = 1,
            path = 3,
            shorting_target = 40,
            symbols = {
                modified = '',
                readonly = '[-]',
                unnames = '[No Name]',
                newfile = '[New]',
            },
        }

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'nightfly',
                -- component_separators = { left = '', right = ''},
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { mode },
                lualine_b = {
                    {
                        'branch',
                        icons_enabled = true,
                        icon = {'', align='right', color = {fg='green'}}
                    },
                    {
                        'diff',
                        colored = true,
                        diff_color = {
                            added = {fg='#a1cd5e'},
                            modified = {fg='#e3d18a'},
                            removed = {fg='#fc514e'},
                        },
                        symbols = {added = '+', modified = '~', removed = '-'},
                        source = nil,
                    },
                    diagnostics,
                },
                lualine_c = {},
                lualine_x = { 'filesize' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {
                    { 'mode', },
                    diagnostics,
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    { 'progress' },
                    { 'location' },
                },
                lualine_z = {}
            },
            tabline = {
                lualine_a = { Harpoon_files },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            winbar = {
                lualine_b = { filename },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = { filename },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },

            extensions = {}
        }
    end
}
