-- require lazy in safety mode
local status, lazy = pcall(require, "lazy")
if not status then
	return vim.notify("lazy is not installed.")
end

vim.g.mapleader = " "

lazy.setup({
	{ import = "ecuas.plug.cmds" },
	{ import = "ecuas.plug.keys" },
	{ import = "ecuas.plug.looks" },
	{ import = "ecuas.plug.local" },
	{ import = "ecuas.plug.base.lsp" },
	{ import = "ecuas.plug.base.tele" },
	{ import = "ecuas.plug.base.ts" },
}, {
	-- options
	ui = {
		border = "single",
	},
	change_detection = { notify = false }
})
