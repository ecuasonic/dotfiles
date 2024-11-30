vim.cmd([[hi IndentLine guifg=#505050]])
return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
        require("ibl").setup {
            enabled = true,
            -- indent = "¦", -- │, |, ¦, ┆, ┊
            indent = { char = "┊", highlight = "IndentLine" },
            whitespace = { highlight = { "Whitespace", "NonText" } },
            scope = { enabled = false },
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
    end,
}
