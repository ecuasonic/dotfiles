-- leader keymap
vim.g.mapleader = " " -- space key

-- for conciseness
local k = vim.keymap.set

-- Search
k('v', '/', "\"fy/<C-R>f<CR>")
k('n', '<leader>/', "/<C-R>+<CR>")

-- Jumplist
k('n', '<C-o>', '<C-o>zz')
k('n', '<C-i>', '<C-i>zz')

-- Quickfix
k('n', '<C-q>', '<cmd>copen<CR>zz')
k('n', 'q]', '<cmd>cnext<CR>zz')
k('n', 'q[', '<cmd>cprev<CR>zz')

-- Multi-line Indentation in Visual Mode
k("v", "<Tab>", ">gv^")
k("v", "<S-Tab>", "<gv^")

-- Creating space before or after line in Normal Mode
k("n", "<A-o>", "o<ESC>")
k("n", "<A-O>", "O<ESC>")

-- Moves highlighted segments of code up and down
k("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted code up " })
k("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted code down " })

-- Removes newline char at end of line and keeps cursor at start of line
k("n", "J", "mzJ'z")

-- Keeps search terms, top view
k("n", "n", "nzz")
k("n", "N", "Nzz")

-- greatest remap ever
-- You can paste to replace words, without the deleted words going into buffer
k("x", "p", "\"_dP", { desc = "Paste over words, w/o going into buffer" })
k("x", "<leader>p", "\"_d\"+P", { desc = "Paste over words, from clipboard, w/o going into buffer"})
k("n", "<leader>p", "\"+p", { desc = "Paste from clipboard"})
k("n", "<leader>P", "\"+P", { desc = "Paste from clipboard ()"})

-- next greatest remap ever : asbjornHaland
-- Yank into system clipboard
k("n", "<leader>y", "\"+y", { desc = "Yank into sys-clipboard" })
k("v", "<leader>y", "\"+y", { desc = "Yank into sys-clipboard" })
k("n", "<leader>yy", "\"+Y", { desc = "Yank line into sys-clipboard" })

-- Delete to void register
k("n", "<leader>d", "\"_d", { desc = "Delete into void register" })
k("v", "<leader>d", "\"_d", { desc = "Delete into void register" })
k("n", "<leader>dd", "\"_dd", { desc = "Delete line into void reigster" })

k("n", "Q", "<nop>")

k("n", "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gIc<Left><Left><Left><Left>",
    { desc = "Replace current word" })

vim.cmd([[highlight ColorColumn ctermbg=235 guibg=#383c44]])

--------- obsidian ---------
k("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Obsidian templates" })
k("n", "<leader>on", ":ObsidianNew ", { desc = "Obsidian New Page" })
k("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Obsidian New Daily" })
k("n", "<leader>or", "<cmd>ObsidianRename<cr>", { desc = "Obsidian Rename" })
k("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "Obsidian Links" })
k("n", "<leader>om", "<cmd>ObsidianBridgeTelescopeCommand<cr>", { desc = "Obsidian Bridge Menu" })
k("n", "<leader>oT", "<cmd>ObsidianTags<cr>", { desc = "Obsidian Tags" })
k("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        vim.cmd("normal! m'")
        vim.cmd("ObsidianFollowLink")
        --TODO: hook into the completion of the Obsidian link resolution itself
        -- ensuring that the cursor positioning happens once the link is fully followed
        -- and the note is opened.
        -- Involves the callback or even that triggers when the link is fully opened.
        vim.defer_fn(function()
            vim.cmd("normal! zt")  -- Run zt after the link is followed
        end, 50)
    else
        vim.cmd("normal! gf")
        vim.cmd("normal! zt")
    end
end)
