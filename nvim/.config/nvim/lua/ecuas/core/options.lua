-- for conciseness
local opt = vim.opt -- vim options

opt.path:append("/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr/include/")
vim.g.leetcode_browser = "firefox" -- or "chrome"

-- xxd would interpret \n at end of file.
opt.fixendofline = false

opt.shell = "/bin/zsh"

opt.foldmethod = "marker"
opt.foldmarker = "{,}"
opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

vim.lsp.set_log_level("off")

opt.linebreak = true

opt.mouse = ""

opt.conceallevel = 2
opt.history = 100

opt.showmode = true

-- tabs & indentation
-- Set tabstop to 8 for C, C++, and header files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h" },
    callback = function()
        opt.tabstop = 8
        opt.softtabstop = 8
        opt.shiftwidth = 8
    end,
})

-- Set tabstop to 4 for all other files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "c" and vim.bo.filetype ~= "cpp" and vim.bo.filetype ~= "h" then
            opt.tabstop = 4
            opt.softtabstop = 4
            opt.shiftwidth = 4
        end
    end,
})

opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- line wrapping
opt.wrap = true

-- search settings
opt.smartcase = true
opt.ignorecase = true

-- cursor line
opt.cursorline = false
opt.cursorcolumn = false

-- appearance
opt.termguicolors = true

-- split window
opt.splitright = true
opt.splitbelow = true

-- no backups
opt.backup = false
opt.swapfile = false

-- autoread files when it changes
opt.autoread = true

-- completion window
opt.pumheight = 10

-- hide empty lines symbol ~
opt.fillchars = { eob = " " }

-- undotree options
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undo")

opt.hlsearch = true
opt.incsearch = false

opt.scrolloff = 8
opt.isfname:append("@-@")

opt.colorcolumn = "80"
