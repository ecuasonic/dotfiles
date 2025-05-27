-- for conciseness
local opt = vim.opt -- vim options

vim.o.winborder = 'rounded'
-- opt.completeopt = 'noselect,fuzzy,longest,popup,menu,menuone'

opt.tags = { "./tags;" }
opt.path:append("/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr/include/")
vim.g.leetcode_browser = "firefox" -- or "chrome"

-- ssh/scp gatech
vim.g.netrw_list_hide = "^\\(Any\\|Data\\|By\\|This\\|authorized\\|expectation\\|intercepted\\|policies\\).*"
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- xxd would interpret \n at end of file.
opt.fixendofline = false
opt.jumpoptions:append("stack")

opt.shell = "/bin/zsh"
opt.ar = true
opt.cmdwinheight = 10

opt.foldmethod = "marker"
opt.foldmarker = "{,}"
opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

vim.lsp.set_log_level("off")

opt.linebreak = true
opt.breakindent = true

opt.mouse = "nv"

opt.conceallevel = 2
opt.history = 100

opt.showmode = true

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
-- opt.fillchars = { eob = " " }

-- undotree options
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undo")

opt.hlsearch = true
opt.incsearch = false

opt.scrolloff = 8
opt.isfname:append("@-@")

opt.colorcolumn = "80"
