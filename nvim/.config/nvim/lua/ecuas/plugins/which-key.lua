return {
    "folke/which-key.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    event = "VeryLazy",
    opts = {
        preset = "helix",
        triggers = {
            { "<leader><leader><leader>", mode = {"n", "v"} },
        },
        keys = {
            scroll_down = "<c-e>",
            scroll_up = "<c-y>",
        },
    },
}
