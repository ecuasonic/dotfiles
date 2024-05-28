-- for conciseness
local opt = vim.opt -- vim options

-- hide -- INSERT on lualine
opt.showmode = false

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- line wrapping
opt.wrap = true

-- search settings
opt.smartcase = true
opt.ignorecase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"

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

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 8
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"
vim.cmd([[highlight ColorColumn ctermbg=235 guibg=#383c44]])
vim.cmd([[highlight Comment cterm=NONE term=NONE gui=NONE ctermfg=white guifg=white]])

opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
