-- Core highlights.
vim.cmd([[hi Comment guifg=yellow guibg=NONE]])
vim.cmd([[hi TreesitterContext guibg=NONE]])

-- Markdown highlights.
vim.cmd([[hi RenderMarkdownCodeInline guifg=#FFC133 guibg=NONE]])
vim.cmd([[hi @markup.raw.markdown_inline guifg=#FFC133 guibg=NONE]])
vim.cmd([[hi @markup.link.label guifg=#c792ea guibg=NONE]])
vim.cmd([[hi link RenderMarkdownLink_Custom SpecialChar]])

-- Change color for arrows in tree to light blue.
vim.cmd([[hi NvimTreeIndentMarker guifg=#3FC5FF ]])

-- Indent line plugin.
vim.cmd([[hi IndentLine guifg=#505050]])
