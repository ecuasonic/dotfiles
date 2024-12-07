M = {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon.setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add current file to Harpoon." })
        vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Toggle Harpoon menu" })

        vim.keymap.set("n", "<Space>1", function() harpoon:list():select(1) end, { desc = "harpoon to file 1" })
        vim.keymap.set("n", "<Space>2", function() harpoon:list():select(2) end, { desc = "harpoon to file 2" })
        vim.keymap.set("n", "<Space>3", function() harpoon:list():select(3) end, { desc = "harpoon to file 3" })
        vim.keymap.set("n", "<Space>4", function() harpoon:list():select(4) end, { desc = "harpoon to file 4" })
        vim.keymap.set("n", "<Space>5", function() harpoon:list():select(5) end, { desc = "harpoon to file 5" })
        vim.keymap.set("n", "<Space>6", function() harpoon:list():select(6) end, { desc = "harpoon to file 6" })
        vim.keymap.set("n", "<Space>7", function() harpoon:list():select(7) end, { desc = "harpoon to file 7" })
        vim.keymap.set("n", "<Space>8", function() harpoon:list():select(8) end, { desc = "harpoon to file 8" })
    end
}

--return {}
return M
