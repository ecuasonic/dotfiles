-- leader keymap
vim.g.mapleader = " " -- space key

-- for conciseness
local k = vim.keymap.set
local opts = { noremap = true, silent = true }

k('n', '<leader><leader>o', 'o<ESC>cc', { desc = "next line - no comment" })
k('n', '<leader><leader>O', 'O<ESC>cc', { desc = "next line - no comment" })
k('n', '<leader>=', function() vim.lsp.buf.format() end, { desc = "Format Entire File." })
k('n', '<leader>\\', '<c-w>v', { desc = "Open new window vertically." })
k('n', '<leader>-', '<c-w>s', { desc = "Open new window horizontally." })

-- mouse
k({'n', 'v'}, '<RightMouse>', "<LeftMouse><cmd>lua vim.lsp.buf.hover()<CR>", opts)
k('n', '<X2Mouse>', "<C-i>", opts)
k('n', '<X1Mouse>', "<C-o>", opts)
k('v', '<X2Mouse>', "<Esc>", opts)
k('v', '<X1Mouse>', "<Esc>", opts)
k({'n', 'v'}, '<2-X2Mouse>', "<Nop>", opts)
k({'n', 'v'}, '<2-X1Mouse>', "<Nop>", opts)

-- lsp
k("n", "<leader>gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
k("n", "<leader>gi", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
k("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
k("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
k("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
k("n", "<leader>gr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
k("n", "<leader>.", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

-- close all floating windows
k("n", "<esc>", function()
    for _, win in pairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative == 'win' then
            vim.api.nvim_win_close(win, false)
        end
    end
end, opts)

-- Checkbox entire v-line selected.
k('v', '<leader><cr>',
    function()
        local start_line = vim.fn.line('v')
        local end_line = vim.fn.line('.');

        -- Ensure the range is in the correct order
        if start_line > end_line then
            start_line, end_line = end_line, start_line
        end

        -- Iterate over each line in the range
        for line_num = start_line, end_line do
            vim.api.nvim_win_set_cursor(0, { line_num, 0 })
            require("obsidian").util.toggle_checkbox()
        end
        local t = function(str)
            return vim.api.nvim_replace_termcodes(str, true, true, true)
        end
        vim.api.nvim_feedkeys(t('<ESC>'), 'n', true)
    end, { desc = "Markdown Checkbox V-Line Select." })

k('n', '<leader>z',
    function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    { desc = "Enable Inlay Hints for Functions." }
)

k('n', "yc", "yy<cmd>normal gcc<CR>p", { desc = "Yank, comment out, then paste." })

k("n", "<leader>x", ":!", { desc = "Execute Shell Command." })
k("n", "<leader>X", ":%!", { desc = "Change Entire File to Sheel Command." })
-- k("n", "<ESC>", "<cmd>noh<CR>")

k("n", "+", "<C-a>", { desc = "Increment numbers.", noremap = true })
k("n", "-", "<C-x>", { desc = "Decrement numbers.", noremap = true })

-- Search
k('v', '/', "\"fy/<C-R>f<CR>", { desc = "Search highlighted text in current buffer." })
k('n', '<leader>/', "/<C-R>+<CR>", { desc = "Search clipboarded text in current buffer." })

-- Jumplist
k('n', '<C-o>', '<C-o>zz', { desc = "Go to previous jumplist centered." })
k('n', '<C-i>', '<C-i>zz', { desc = "Go to next jumplist centered." })

-- Quickfix
k('n', '<C-q>', '<cmd>copen<CR>zz', { desc = "Open Quickfix." })
k('n', '[q', '<cmd>cprev<CR>zz', { desc = "Go to previous quickfix centered." })
k('n', ']q', '<cmd>cnext<CR>zz', { desc = "Go to next quickfix centered." })

-- Multi-line Indentation in Visual Mode
k("v", "<Tab>", ">gv^", { desc = "Tab highlighted text." })
k("v", "<S-Tab>", "<gv^", { desc = "UnTab highlighted text." })

-- Moves highlighted segments of code up and down
k("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted code up." })
k("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted code down." })

-- Removes newline char at end of line and keeps cursor at start of line
k("n", "J", "mzJ'z", { desc = "Remove newline character at end of line." })

-- Keeps search terms, top view
k("n", "N", "Nzz", { desc = "Go to previous search centered" })
k("n", "n", "nzz", { desc = "Go to next search centered." })

-- greatest remap ever
-- You can paste to replace words, without the deleted words going into buffer
k("x", "p", "\"_dP", { desc = "Paste over words, w/o going into buffer." })
k("x", "<leader>p", "\"_d\"+P", { desc = "Paste over words from clipboard, w/o going into buffer." })
k("n", "<leader>p", "\"+p", { desc = "Paste (p) from clipboard." })
k("n", "<leader>P", "\"+P", { desc = "Paste (P) from clipboard." })

-- next greatest remap ever : asbjornHaland
-- Yank into system clipboard
-- Trust that this is what you want for neoclip.
--      When using "+, you automatically use "" as well.
k({ "v", "n" }, "<leader>y", "\"+y", { desc = "Yank into sys-clipboard." })
k("n", "<leader>yy", "\"+yy", { desc = "Yank line into sys-clipboard." })

-- Delete to void register
k({ "v", "n" }, "<leader>d", "\"_d", { desc = "Delete into void register." })
k("n", "<leader>dd", "\"_dd", { desc = "Delete line into void reigster." })

k("n", "Q", "<nop>")

k("n", "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gIc<Left><Left><Left><Left>",
    { desc = "Replace current word within current buffer." })

--------- obsidian ---------
k("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Obsidian templates" })
k("n", "<leader>on", ":ObsidianNew ", { desc = "Obsidian New Page" })
k("n", "<leader>or", "<cmd>ObsidianRename<cr>", { desc = "Obsidian Rename" })
k("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "Obsidian Links" })
k("n", "<leader>oT", "<cmd>ObsidianTags<cr>", { desc = "Obsidian Tags" })
k("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        vim.cmd("normal! m'")
        vim.cmd("ObsidianFollowLink")
        vim.defer_fn(function()
            vim.cmd("normal! zt") -- Run zt after the link is followed
        end, 100)
    else
        vim.cmd("normal! gf")
        vim.cmd("normal! zt")
    end
end)

k({ "n", "v" }, "<leader>k", "<cmd>WhichKey<CR>", { desc = "Open Which-Key" })
k({ "n", "v" }, "zc", "zM", { desc = "Close all folds." })
k({ "n", "v" }, "zo", "zR", { desc = "Open all folds." })
k({ "n", "v" }, "za", "zA", { desc = "Toggle all folds on cursor." })
