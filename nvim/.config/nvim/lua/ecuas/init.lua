vim.g.mapleader = "."
-- packages
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

-- lazy plugin manager.
require("ecuas.plugin-manager")

-- core setup.
require("ecuas.core.opt")
require("ecuas.core.keys")
require("ecuas.core.term")

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
require("ecuas.core.hi")
require("ecuas.core.autocmds")
