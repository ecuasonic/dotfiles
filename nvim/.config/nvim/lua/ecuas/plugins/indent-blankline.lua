local highlight = {
    "CursorColumn",
    "Whitespace",
}

return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
        require("ibl").setup {
            enabled = true,
            indent = { char = "┊" },
            whitespace = { highlight = { "Whitespace", "NonText" } },
            scope = { enabled = true },
        }
    end,
}
