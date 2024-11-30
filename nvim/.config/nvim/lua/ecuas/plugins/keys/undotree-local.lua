local local_plugins = {
    {
        "undotree",
        dir = "~/local/undotree",
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
        end
    },
}

return local_plugins
