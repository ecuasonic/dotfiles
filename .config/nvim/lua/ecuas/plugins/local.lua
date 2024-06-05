local local_plugins = {
    {
        "undotree",
        dir = "~/local/undotree",
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
        end
    },
    {
        "bufferline",
        dir = "~local/bufferline.nvim",
    }
}

return local_plugins
