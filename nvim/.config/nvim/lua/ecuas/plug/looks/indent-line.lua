M = {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
        require("ibl").setup {
            enabled = true,
            -- indent = "¦", -- │, |, ¦, ┆, ┊
            indent = {
                char = "▏",
                smart_indent_cap = true,
                highlight = "IndentLine",
            },
            whitespace = {
                highlight = { "Whitespace", "NonText" },
                remove_blankline_trail = true,
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = true
            },
            exclude = {
                filetypes = {
                    'lspinfo',
                    'checkhealth',
                    'markdown',
                    'man',
                    'dashboard',
                    '',
                },
            },

        }
    end
}

-- return {}
return M
