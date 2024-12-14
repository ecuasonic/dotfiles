-- lazy plugin manager.
require("ecuas.plugin-manager")

-- core setup.
require("ecuas.core.options")
require("ecuas.core.remap")

-- element setup
require("ecuas.elements.statuscolumn")

-- load plugins.
require("ecuas.plugins-setup")

require("ecuas.elements.winbar")     -- needs gitsigns
require("ecuas.elements.statusline") -- needs fugitive
require("ecuas.elements.tabline")    -- needs harpoon

-- vim.o.path = vim.o.path .. "/usr/avr/include,/home/ecuas/.arduino15/,/usr/lib/gcc/avr/14.1.0/include,/usr/lib/gcc/avr/14.1.0/include-fixed"

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ'
    }
})

-- load everything else last.
require("ecuas.core.autocmds")
require("ecuas.core.highlights")
