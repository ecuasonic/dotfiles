-- for conciseness
local opt = vim.opt -- vim options

opt.path:append("/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr/include/")

-- xxd would interpret \n at end of file.
opt.fixendofline = false

opt.foldmethod = "marker"
opt.foldmarker = "{,}"
vim.lsp.set_log_level("off")

opt.linebreak = true

opt.mouse = ""

opt.conceallevel = 2
opt.history = 100

-- hide -- INSERT on lualine
opt.showmode = false

-- line numbers
opt.relativenumber = true
opt.number = true
-- vim.cmd('highlight WhiteNum guifg=white')
-- vim.cmd('highlight GreyNum guifg=grey')
-- vim.opt.statuscolumn = "%#GreyNum#%l%=%#WhiteNum#%r │"

-- tabs & indentation
opt.tabstop = 8
opt.softtabstop = 8
opt.shiftwidth = 8
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
opt.cursorcolumn = false

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

opt.hlsearch = true
opt.incsearch = false

opt.scrolloff = 8
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
