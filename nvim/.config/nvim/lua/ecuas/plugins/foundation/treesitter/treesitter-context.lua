return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        enable = true, -- enable on all buffers by default
        -- separator = "-", -- ─, -, .
        separator = "-",
    },
}
