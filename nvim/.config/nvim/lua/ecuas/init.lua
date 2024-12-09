-- core setup.
require("ecuas.core.plugin-manager")
require("ecuas.core.options")
require("ecuas.core.remap")
require("ecuas.core.config")

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
require("ecuas.autocmds")
require("ecuas.highlights")
require("ecuas.border")
