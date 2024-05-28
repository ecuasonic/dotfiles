-- import
local telescope = require("ecuas.extensions.lualine.telescope")
local saga = require("ecuas.extensions.lualine.saga")
local lspinfo = require("ecuas.extensions.lualine.lspinfo")

-- available extensions
local extensions = {
    telescope = telescope,
    saga = saga,
    lspinfo = lspinfo,
}

-- export
return extensions
