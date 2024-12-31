vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "(\\./[^)]*)")
			vim.fn.matchadd("TelescopeParent", "(\\.)")
			vim.api.nvim_set_hl(0, "TelescopeParent", { fg = 'gray' })
			vim.fn.matchadd("Icon", "^[^a-zA-Z0-9]*")
			vim.api.nvim_set_hl(0, "Icon", { fg = 'orange' })
		end)
	end,
})

local function path_dirname(opts, path)
	local filename = vim.fs.basename(path)
	local dirname = vim.fs.dirname(path)
	local output = ""
	if (dirname == '.') then
		output = string.format("%s (.)", filename)
	else
		output = string.format("%s (%s)", filename, "./" .. dirname)
	end
	return string.format("%-30s", output)
end

function Path_Current_File(opts, path)
	local filename = vim.fs.basename(path)
	local dirname = vim.fs.dirname(path)
	local output = ""
	if (dirname == '.' or vim.fn.expand(dirname)) then
		output = string.format("%s (.)", filename)
	else
		output = string.format("%s (%s)", filename, "./" .. dirname)
	end
	return string.format("%-15s", output)
end

local function path_parent(opts, path)
	local filename = vim.fs.basename(path)
	local pwd_len = string.len(vim.fn.system('pwd'))
	local parent = vim.fs.dirname(path)
	parent = string.sub(parent, pwd_len, -1)
	return string.format("%s (%s)", filename, '.' .. parent)
end

local function setup_keys(builtin)
	vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy Find." })
	-- This allows for multiple words on same target line.
	vim.keymap.set('n', '<leader>fs', function()
		local opts = {
			shorten_path = true,
			word_match = "-w",
			only_sort_text = true,
			search = '',
		}
		require("telescope.builtin").grep_string(opts)
	end, { desc = "Fuzzy Search." })
	-- Stores highlighted word into register then search through grep_string.
	vim.keymap.set('v', '<leader>fs', function()
		local old_reg_unnamed = vim.fn.getreg('""')
		vim.cmd('normal! "zy')
		local selected_text = vim.fn.getreg('z') .. " "
		vim.fn.setreg('""', old_reg_unnamed)
		local opts = {
			shorten_path = true,
			word_match = "-w",
			only_sort_text = true,
			search = '',
		}
		require("telescope.builtin").grep_string(opts)
		vim.api.nvim_feedkeys(selected_text, "n", true)
	end, { desc = "Fuzzy Current Selected Text" })
	vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope Buffers.' })
	vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope Jumplist' })
	vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope Diagnostics' })
	vim.keymap.set('n', '<leader>ft', "<cmd>TodoTelescope<CR>", { desc = 'Telescope Todos' })
	vim.keymap.set('n', '<leader>f/',
		function()
			local opts = {
				search_dirs = {
					vim.fn.expand("%:p")
				},
				shorten_path = true,
				word_match = "-w",
				only_sort_text = true,
				search = '',
			}
			require("telescope.builtin").grep_string(opts)
		end,
		{ desc = 'Fuzzy Find in current buffer' })
end

M = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sharkdp/fd",
		"BurntSushi/ripgrep",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local z_utils = require("telescope._extensions.zoxide.utils")
		local builtin = require('telescope.builtin')

		telescope.setup({
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				zoxide = {
					prompt_title = "[ Zoxide List ]",
					list_command = "zoxide query -ls",
					mappings = {
						default = {
							action = function(selection)
								vim.cmd.cd(selection.path)
							end,
							after_action = function(selection)
								vim.notify("Directory changed to " .. selection.path)
							end,
						},
						["<C-f>"] = {
							keepinsert = true,
							action = function(selection)
								builtin.find_files({ cwd = selection.path })
							end,
						}
					}
				},
			},
			pickers = {
				lsp_references = {
					path_display = path_parent
				},
				find_files = {
					path_display = path_dirname,
					previewer = false,
					layout_strategy = "vertical",
					layout_config = {
						height = 0.50,
						width = 0.40,
					},
				},
				live_grep = {
					path_display = path_dirname
				},
				grep_string = {
					path_display = path_dirname
				},
			},
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--trim",
				},
				color_devicons = false,
				selection_caret = ' ',
				sorting_strategy = 'descending',
				selection_strategy = 'reset',
				scroll_strategy = 'limit',
				layout_strategy = 'vertical',
				path_display = { "truncate" },
				wrap_results = false,
				entry_prefix = ' ',
				initial_mode = 'insert',
				border = true,
				layout_config = {
					height = 0.95,
					width = 0.98,
				},
				file_ignore_patterns = {
					"%.o",
					"%.png",
					"%.jpg",
					"%.pdf",
					".gitignore",
					"%/obj/%",
					"%/bin/%",
				},
				mappings = {
					i = {
						["<c-d>"] = require('telescope.actions').delete_buffer,
						["<ESC>"] = actions.close,
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,

						["<C-y>"] = actions.preview_scrolling_up,
						["<C-e>"] = actions.preview_scrolling_down,

						["<C-/>"] = actions.which_key,
					},
				}
			},
		})


		---------------------------------------------------------------
		-------------- LSP Functions and Keymaps ----------------------
		---------------------------------------------------------------
		vim.keymap.set('n', '<leader>gs', builtin.lsp_references, { desc = "Telescope References" })
		vim.keymap.set('n', '<leader>fe', builtin.lsp_document_symbols, { desc = "Telescope Symbols" })

		-- In init.lua:
		-- vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.rename() end, opts)
		-- vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.declaration() end, opts)
		-- vim.keymap.set("n", "<leader>gi", function() vim.lsp.buf.definition() end, opts)

		-- In remap.lua:
		-- keymap.set("n", "gf", function()
		--     if require("obsidian").util.cursor_on_markdown_link() then
		--         vim.cmd("normal! m'")
		--         vim.cmd("ObsidianFollowLink")
		--         vim.defer_fn(function()
		--             vim.cmd("normal! zt")  -- Run zt after the link is followed
		--         end, 50)
		--     else
		--         vim.cmd("normal! gf")
		--         vim.cmd("normal! zt")
		--     end
		-- end)


		------------------------------------------------------------------
		--------------------------- Zoxide -------------------------------
		------------------------------------------------------------------
		telescope.load_extension('zoxide')
		vim.keymap.set('n', '<leader>cd', function()
			telescope.extensions.zoxide.list({
				wrap_results = true,
			})
		end, { desc = "Telescope cd." })
		vim.keymap.set('n', '<leader>fc', ":Telescope neoclip<CR>", { desc = "Telescope Clipboard." })

		------------------------------------------------------------------
		------------------------------ FZF -------------------------------
		------------------------------------------------------------------
		telescope.load_extension('fzf')

		setup_keys(builtin)
	end
}

-- return {}
return M
