M = {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
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
}

-- return {}
return M
