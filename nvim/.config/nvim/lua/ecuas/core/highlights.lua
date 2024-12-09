-- Core highlights.
vim.cmd([[hi Comment guifg=yellow guibg=NONE]])
vim.cmd([[hi TreesitterContext guibg=NONE]])

-- Markdown highlights.
vim.cmd([[hi RenderMarkdownCodeInline guifg=#FFC133 guibg=NONE]])
vim.cmd([[hi @markup.raw.markdown_inline guifg=#FFC133 guibg=NONE]])

-- Lualine tabline harpoon colors.
vim.cmd([[highlight HarpoonNumberActive ctermfg=255 guifg=orange guibg=#010005]])
vim.cmd([[highlight HarpoonActive ctermfg=255 guifg=cyan guibg=#010005]])
vim.cmd([[highlight HarpoonNumberInactive ctermfg=255 guifg=orange guibg=#010005]])
vim.cmd([[highlight HarpoonInactive ctermfg=255 guifg=white guibg=#010005]])

-- Change color for arrows in tree to light blue.
vim.cmd([[ highlight NvimTreeIndentMarker guifg = #3FC5FF ]])

-- Highlight groups for statuscolumn.
vim.cmd([[hi CustomLineNr guifg=white guibg=#74125C gui=bold]])
vim.cmd([[hi White guifg=white]])

-- Indent line plugin.
vim.cmd([[hi IndentLine guifg=#505050]])

-- set diagnostic signs highlights and symbols
local signs = {
    Error = " ",
    Warn = " ",
    Hint = "󰛩 ",
    Info = " "
}
for type, icon in pairs(signs) do
    -- define diagnostic type
    local hl = "DiagnosticSign" .. type

    -- set icon for diagnostic type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl,
    })
end
