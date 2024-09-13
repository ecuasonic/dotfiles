-- leader keymap
vim.g.mapleader = " " -- space key

-- for conciseness
local keymap = vim.keymap -- keymaps
keymap.set('n', ';', "")

-- Multi-line Indentation in Visual Mode
keymap.set("v", "<Tab>", ">gv^")
keymap.set("v", "<S-Tab>", "<gv^")

-- Creating space before or after line in Normal Mode
keymap.set("n", "<A-o>", "o<ESC>")
keymap.set("n", "<A-O>", "O<ESC>")

-- Moves highlighted segments of code up and down
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted code up " })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted code down " })

-- Removes newline char at end of line and keeps cursor at start of line
keymap.set("n", "J", "mzJ'z")

-- Keeps search terms in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- You can paste to replace words, without the deleted words going into buffer
keymap.set("x", "p", "\"_dP", { desc = "Paste over words, w/o going into buffer" })
keymap.set("x", "<leader>p", "\"_d\"+P", { desc = "Paste over words, from clipboard, w/o going into buffer"})
keymap.set("n", "<leader>p", "\"+p", { desc = "Paste from clipboard"})
keymap.set("n", "<leader>P", "\"+P", { desc = "Paste from clipboard ()"})

-- next greatest remap ever : asbjornHaland
-- Yank into system clipboard
keymap.set("n", "<leader>y", "\"+y", { desc = "Yank into sys-clipboard" })
keymap.set("v", "<leader>y", "\"+y", { desc = "Yank into sys-clipboard" })
keymap.set("n", "<leader>yy", "\"+Y", { desc = "Yank line into sys-clipboard" })

-- Delete to void register
keymap.set("n", "<leader>d", "\"_d", { desc = "Delete into void register" })
keymap.set("v", "<leader>d", "\"_d", { desc = "Delete into void register" })
keymap.set("n", "<leader>dd", "\"_dd", { desc = "Delete line into void reigster" })

keymap.set("n", "Q", "<nop>")
-- keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<C-f>", function()
        vim.lsp.buf.format()
    end,
    { desc = "Format file" })

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

--------- Markdown ---------------
keymap.set('n', "<leader>m", ":MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown" })

--------- obsidian ---------
keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Obsidian templates" })
keymap.set("n", "<leader>on", ":ObsidianNew ", { desc = "Obsidian New Page" })
keymap.set("n", "<leader>od", "<cmd>ObsidianDailies<cr>", { desc = "Obsidian New Daily" })
keymap.set("n", "<leader>or", "<cmd>ObsidianRename<cr>", { desc = "Obsidian Rename" })
keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "Obsidian Links" })
keymap.set("n", "<leader>om", "<cmd>ObsidianBridgeTelescopeCommand<cr>", { desc = "Obsidian Bridge Menu" })
keymap.set("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        return "m'<cmd>ObsidianFollowLink<CR> zz"
    else
        return "gfzz"
    end
end, { noremap = false, expr = true })
