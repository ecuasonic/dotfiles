M = {
    "folke/ts-comments.nvim",
    opts = {
        lang = {
            c = "// %s",
            verilog = "// %s"
        }
    },
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
}
return M
-- return {}
