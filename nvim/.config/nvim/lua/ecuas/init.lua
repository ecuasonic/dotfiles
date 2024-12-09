-- lazy plugin manager.
require("ecuas.plugin-manager")

-- core setup.
require("ecuas.core.options")
require("ecuas.core.remap")

-- load plugins.
require("ecuas.plugins-setup")

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
