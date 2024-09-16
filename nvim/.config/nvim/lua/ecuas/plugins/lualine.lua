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
        vim.cmd([[highlight HarpoonNumberActive ctermfg=255 guifg=orange]])
        vim.cmd([[highlight HarpoonActive ctermfg=255 guifg=cyan]])
        vim.cmd([[highlight HarpoonNumberInactive ctermfg=255 guifg=orange]])
        vim.cmd([[highlight HarpoonInactive ctermfg=255 guifg=white]])

    end

    return table.concat(contents)
end

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
        readonly = '[READ-ONLY]',
        unnames = '[No Name]',
        newfile = '[New]',
    },
}


local default_color = {fg = '#ffffff', bg = '#090a15'}
local boring_color =  {
    replace = {
        a = default_color,
        b = default_color,
        c = default_color,
    },
    inactive = {
        a = default_color,
        b = default_color,
        c = default_color,
    },
    normal = {
        a = default_color,
        b = default_color,
        c = {fg = '#ffa500', bg = '#090a15'}
    },
    visual = {
        a = default_color,
        b = default_color,
        c = default_color,
    },
    insert = {
        a = default_color,
        b = default_color,
        c = default_color,
    },
    command = {
        a = default_color,
        b = default_color,
        c = default_color,
    }
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "theprimeagen/harpoon"
    },
    config = function()

        -- custom_nightfly.tabline = { fg = '#ffffff'}

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = boring_color,
                -- component_separators = { left = '', right = ''},
                -- component_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                -- section_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1500,
                    tabline = 1500,
                    winbar = 1500,
                }
            },
            sections = {
                lualine_a = {},
                lualine_b = {
                    {
                        'mode',
                        fmt = function(str)
                            if str == "NORMAL" then
                                return ""
                            else
                                return "--" .. str .. "--"
                            end
                        end
                    },
                    diagnostics,
                },
                lualine_c = {
                    {
                        function()
                            return _G.custom_status_message
                        end,
                        cond = function()
                            return _G.custom_status_message ~= ''
                        end
                    }
                },

                lualine_x = {},
                lualine_y = {
                    {'hostname'},
                    {
                        'branch',
                        icons_enabled = true,
                        icon = {'', align='right', color = {fg='green'}}
                    },
                    { 'progress' },
                    { 'location' },
                },
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {
                    {
                        'mode',
                        fmt = function(str)
                            if str == "NORMAL" then
                                return ""
                            else
                                return "--" .. str .. "--"
                            end
                        end
                    },
                    diagnostics,
                },
                lualine_c = {},
                lualine_x = {
                    {
                        'branch',
                        icons_enabled = true,
                        icon = {'', align='right', color = {fg='green'}}
                    },
                    -- {
                    --     'diff',
                    --     colored = true,
                    --     diff_color = {
                    --         added = {fg='#a1cd5e'},
                    --         modified = {fg='#e3d18a'},
                    --         removed = {fg='#fc514e'},
                    --     },
                    --     symbols = {added = '+', modified = '~', removed = '-'},
                    --     source = nil,
                    -- },
                    { 'progress' },
                    { 'location' },
                },
                lualine_y = {},
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
                lualine_y = {'filesize'},
                lualine_z = {}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = { filename },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {'filesize'},
                lualine_z = {}
            },

            extensions = {}
        }
    end
}
