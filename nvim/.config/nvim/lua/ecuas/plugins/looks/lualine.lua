-- Put this into tabline.
function Harpoon_files()
    local contents = {}
    local marks_length = require("harpoon"):list():length()
    local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
    for index = 1, marks_length do
        local harpoon_file_path = require("harpoon"):list():get(index).value
        local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ':t')

        if current_file_path == harpoon_file_path then
            contents[index] = string.format("%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ", index,
                file_name)
        else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index,
                file_name)
        end
    end

    return table.concat(contents)
end

local function get_timerly_status()
    local state = require("timerly.state")
    if state.progress == 0 then
        return ""
    end

    local total = math.max(0, state.total_secs + 1) -- Add 1 to sync with timer display
    local mins = math.floor(total / 60)
    local secs = total % 60

    return string.format("%s %02d:%02d", state.mode:gsub("^%l", string.upper), mins, secs)
end

local diff = {
    'diff',
    colored = true,
    diff_color = {
        added = { fg = '#a1cd5e' },
        modified = { fg = '#e3d18a' },
        removed = { fg = '#fc514e' },
    },
    symbols = { added = '+', modified = '~', removed = '-' },
    source = nil,
}

local diagnostics = {
    'diagnostics',
    sources = { 'nvim_lsp' },
    sections = { 'error', 'warn', 'info', 'hint' },
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
        modified = '[+]',
        readonly = '[READ-ONLY]',
        unnames = '[No Name]',
        newfile = '[New]',
    },
}


-- local background = '#090a15'
local background = '#010005'
local active = { fg = '#ffffff' }
local inactive = { fg = '#ffffff', bg = '#23242F' }
local important = { fg = '#ffa500' }
local boring_color = {
    replace = {
        a = active,
        b = active,
        c = important,
    },
    inactive = {
        a = inactive,
        b = inactive,
        c = important,
    },
    normal = {
        a = active,
        b = active,
        c = important,
    },
    visual = {
        a = active,
        b = active,
        c = important,
    },
    insert = {
        a = active,
        b = active,
        c = important,
    },
    command = {
        a = active,
        b = active,
        c = important,
    },
    tabline = {
        a = active,
        b = active,
        c = important,
    }
}

M = {
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
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1,
                    tabline = 100,
                    winbar = 100,
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
                },
                lualine_c = {},
                lualine_x = { get_timerly_status },
                lualine_y = {
                    {
                        'branch',
                        icons_enabled = false,
                    },
                    { 'hostname' },
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
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
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
                lualine_a = {},
                lualine_b = { filename },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    diff,
                    diagnostics,
                    { 'filesize' },
                },
                lualine_z = {}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = { filename },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    diff,
                    diagnostics,
                },
                lualine_z = {}
            },

            extensions = {}
        }
    end
}

-- return {}
return M
