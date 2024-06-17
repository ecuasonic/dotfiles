-- leader keymap
vim.g.mapleader = " " -- space key

-- for conciseness
local keymap = vim.keymap -- keymaps

-- keymaps to allow for navigation during insert mode
-- use <C-:> instead of <ESC>
keymap.set("i", "jj", "<ESC>")
keymap.set("i", "<C-c>", "<Esc><Esc><Esc>")
keymap.set("i", "<c-h>", "<Left>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
keymap.set("i", "<C-l>", "<Right>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Moves highlighted segments of code up and down
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted code up "})
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted code down "})

-- Removes newline char at end of line and keeps cursor at start of line
keymap.set("n", "J", "mzJ'z")

-- Moves half pages and maintains cursor at center
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Keeps search terms in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- You can paste to replace words, without the deleted words going into buffer
keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste over words, w/o going into buffer"})

-- next greatest remap ever : asbjornHaland
-- Yank into system clipboard
keymap.set("n", "<leader>y", "\"+y", { desc = "Yank into sys-clipboard"})
keymap.set("v", "<leader>y", "\"+y", { desc = "Yank into sys-clipboard"})
keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank line into sys-clipboard"})

-- Delete to void register
keymap.set("n", "<leader>d", "\"_d", { desc = "Delete into void register"})
keymap.set("n", "<leader>dd", "\"_dd", { desc = "Delete line into void reigster"})
keymap.set("v", "<leader>d", "\"_d", { desc = "Delete into void register"})

keymap.set("n", "Q", "<nop>")
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end,
    { desc =  "Format file" })

-- Quickfix list
keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Quickfix next" })
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Quickfix prev" })

keymap.set("n", "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Replace current word" })

--vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.cmd([[highlight ColorColumn ctermbg=235 guibg=#383c44]])

-- -- Nvim-ufo
-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all fold" })
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds"})
-- vim.keymap.set('n', 'zK', function()
--     local winid = require('ufo').peekFoldedLinesUnderCursor()
--     if not winid then
--         vim.lsp.buf.hover()
--     end
-- end, { desc = "Peek Fold" })
--
--------- Markdown ---------------
keymap.set('n', "<leader>m", ":MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown" })
