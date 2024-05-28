return {
    "danymat/neogen",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local neogen = require("neogen")

        neogen.setup({
            snippet_engine = "luasnip"
        })

        vim.keymap.set("n", "<leader>nf", function()
            neogen.generate({ type = "func" })
        end,
            { desc = "Function annotation" })

        vim.keymap.set("n", "<leader>nt", function()
            neogen.generate({ type = "type" })
        end,
            { desc = "Type annotation" })

        vim.keymap.set("n", "<leader>nc", function()
            neogen.generate({ type = "class" })
        end,
            { desc = "Class annotation" })

    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
}
