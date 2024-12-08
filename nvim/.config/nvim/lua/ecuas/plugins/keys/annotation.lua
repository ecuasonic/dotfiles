M = {
    "danymat/neogen",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local neogen = require("neogen")

        neogen.setup({
            input_after_comment = true,
            snippet_engine = "luasnip"
        })

        vim.keymap.set("n", "<leader>n", function()
                neogen.generate()
                vim.schedule(function()
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
                end)
            end,
            { desc = "Annotation Generation" })
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
}

-- return {}
return M
