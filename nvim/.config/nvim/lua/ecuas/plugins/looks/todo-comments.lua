return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        vim.keymap.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Next todo comment" })

        vim.keymap.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Previous todo comment" })

        vim.keymap.set("n", "]f", function()
            todo_comments.jump_next({ keywords = { "FIX" } })
        end, { desc = "Next fix comment" })


        vim.keymap.set("n", "[f", function()
            todo_comments.jump_prev({ keywords = { "FIX" } })
        end, { desc = "Next fix comment" })

        todo_comments.setup()
    end,
}
