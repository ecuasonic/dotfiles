-- Core highlights.
vim.cmd([[hi Comment guifg=yellow guibg=NONE]])
vim.cmd([[hi TreesitterContext guibg=NONE]])

-- Elements highlights.
vim.cmd([[hi ModeMsg ctermfg=10 gui=NONE guifg=NvimLightGreen]])
vim.cmd([[hi WinBar ctermfg=10 gui=NONE guifg=white]])
vim.cmd([[hi StatusLine ctermfg=10 gui=NONE guifg=white]])
vim.cmd([[hi Winseparator guifg=orange]])

-- Winbar diff.
vim.cmd([[hi DiffAdded guifg=#a1cd5e]])
vim.cmd([[hi DiffChanged guifg=#e3d18a]])
vim.cmd([[hi DiffRemoved guifg=#fc514e]])

-- Markdown highlights.
vim.cmd([[hi RenderMarkdownCodeInline guifg=#FFC133 guibg=NONE]])
vim.cmd([[hi @markup.raw.markdown_inline guifg=#FFC133 guibg=NONE]])
vim.cmd([[hi @markup.link.label guifg=#c792ea guibg=NONE]])
vim.cmd([[hi link RenderMarkdownLink_Custom SpecialChar]])

-- Lualine tabline harpoon colors.
vim.cmd([[hi HarpoonNumberActive ctermfg=255 guifg=orange guibg=#010005]])
vim.cmd([[hi HarpoonActive ctermfg=255 guifg=cyan guibg=#010005]])
vim.cmd([[hi HarpoonNumberInactive ctermfg=255 guifg=orange guibg=#010005]])
vim.cmd([[hi HarpoonInactive ctermfg=255 guifg=white guibg=#010005]])

-- Change color for arrows in tree to light blue.
vim.cmd([[hi NvimTreeIndentMarker guifg=#3FC5FF ]])

-- Highlight groups for statuscolumn.
vim.cmd([[hi CustomLineNr guifg=white guibg=#74125C gui=bold]])
vim.cmd([[hi Blank guifg=white]])
vim.cmd([[hi Green guifg=NvimLightGreen]])

-- Indent line plugin.
vim.cmd([[hi IndentLine guifg=#505050]])
