M = {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        enable = true, -- enable on all buffers by default
        -- separator = "-", -- ─, -, .
        separator = "─",
        -- on_attach = function()
        --     if vim.bo.filetype == "markdown" then
        --         return false
        --     end
        --     return true
        -- end
    },
}

-- return {}
return M
