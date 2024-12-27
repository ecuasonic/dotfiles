local M = {
    "ecuasonic/elements.nvim",
    dependencies = {
        "theprimeagen/harpoon",
        "tpope/vim-fugitive",
        "lewis6991/gitsigns.nvim",
    },
    config = function()
        require('elements').setup()
    end
}

return {}
-- return M
