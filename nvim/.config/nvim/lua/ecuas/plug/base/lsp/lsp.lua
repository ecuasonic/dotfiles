--
-- main function starts at M
--

--- Set up cmp lsp windows, mappings, sources, etc.
---@param cmp table require('cmp')
---@param lspkind table require('lspkind')
local function cmp_setup(cmp, lspkind)
    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    cmp.setup({
        -- snippet = {
        --     expand = function(args)
        --         require('luasnip').lsp_expand(args.body)
        --     end,
        -- },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = {
            ['<c-j>'] = cmp.mapping({
                c = function()
                    vim.api.nvim_feedkeys(t('<down>'), 'n', true)
                end,
                i = function()
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                end
            }),
            ['<c-k>'] = cmp.mapping({
                c = function()
                    vim.api.nvim_feedkeys(t('<up>'), 'n', true)
                end,
                i = function()
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                end
            }),
            ['<Tab>'] = cmp.mapping.confirm({
                select = true,
                behavior = cmp.ConfirmBehavior.Insert
            }),
        },
        sources = cmp.config.sources(
            {
                { name = 'nvim_lsp', keyword_length = 1},
                -- { name = 'luasnip', keyword_length = 1 },
                { name = 'nvim_lua', keyword_length = 1},
            },
            {
                { name = "path",   keyword_length = 1 },
                { name = 'buffer', keyword_length = 1 },
            }),
        formatting = {
            fields = { "abbr", "kind", "menu" },
            format = lspkind.cmp_format({
                mode = "symbol",
                with_text = true,
                menu = {
                    nvim_lsp = "[LSP]",
                    -- nvim_lua = "[NVLUA]",
                    -- luasnip = "[SNIP]",
                    path = "[PATH]",
                    buffer = "[BUF]",
                },
                maxwidth = 50,
            }),
        },
        view = {
            entries = {
                name = "custom",
                selection_order = "near_cursor",
            },
        },
        enabled = function()
            -- disable completion in comments
            local context = require 'cmp.config.context'
            -- keep command mode completion enabled when cursor is in a comment
            if vim.api.nvim_get_mode().mode == 'c' then
                return true
            elseif vim.bo.filetype == "TelescopePrompt" then
                return false
            else
                return not context.in_treesitter_capture("comment") and
                    not context.in_syntax_group("Comment")
            end
        end,
        experimental = {
            ghost_text = { hl_group = "SpecialKey" }
        },
        -- completion = {
        --     completeopt = 'menu,menuone,noinsert'
        -- }
    })

    -- require("luasnip.loaders.from_vscode").lazy_load()
end

local function mason_setup(capabilities)
    require("mason").setup()


    vim.lsp.config.clangd = {
        capabilities = capabilities,
        cmd = {
            'clangd',
            '-j=2',
            '--background-index=false',
            '--clang-tidy',
            '--enable-config',
            '--function-arg-placeholders=false',
            -- '--indent-case-labels=false'
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        single_file_support = true,
        root_markers = {
            '.clang-tidy',
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac',
            '.git'
        }
    }
    vim.lsp.config.lua_ls = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ';')
                },
                ["completion.enable"] = true,
                diagnostics = {
                    globals = {
                        "vim",
                        "it",
                        "describe",
                        "before_each",
                        "after_each"
                    },
                },
                workspace = {
                    library = {
                        vim.env.VIMRUNTIME,
                        vim.fn.stdpath('config'),
                    },
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false
                }
            }
        }
    }
    vim.lsp.config.asm_lsp = {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "asm", "s", "S" },
        cmd = { "asm-lsp" },
        single_file_support = true,
        root_markers = {
            'compile_commands.json',
            '.git'
        }
    }
    vim.lsp.config.bashls = {
        on_attach = on_attach,
        cmd = {
            "bash-language-server",
            "start"
        },
        settings = {
            bashIde = {
                globPattern = vim.env.GLOB_PATTERN or
                    '*@(.sh|.inc|.bash|.command)',
            }
        },
        filetypes = { "sh" },
        root_markers = {
            '.root'
        }
    }
    vim.lsp.config.verible = {
        on_attach = on_attach,
        cmd = { 'verible-verilog-ls', '--rules_config_search' },
        filetypes = { "systemverilog", "verilog" },
    }
    vim.lsp.enable({
        'clangd',
        'lua_ls',
        'asm_lsp',
        'bashls',
        'verible',
    })
end

M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason.nvim",

        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        -- "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "onsails/lspkind.nvim",
        -- "saadparwaiz1/cmp_luasnip",
        -- "L3MON4D3/LuaSnip",
        "windwp/nvim-autopairs"
    },

    config = function()
        -- Setup nvim-autopairs
        local status_ok, npairs = pcall(require, "nvim-autopairs")
        if not status_ok then
            return
        end

        npairs.setup({
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
                java = false,
            },
            disable_filetype = { "TelescopePrompt", "spectre_panel" },
        })

        -- cmp
        local cmp = require('cmp')
        local lspkind = require("lspkind")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        mason_setup(capabilities)
        cmp_setup(cmp, lspkind)

        vim.diagnostic.config({
            underline = true,
            virtual_text = true,
            -- virtual_lines = true,
            signs = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })

        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done { map_char = { tex = "" } }
        )

        -- local lspconfig = require("lspconfig")
        -- local clangd_opts = require("lsp.clangd")
        -- lspconfig.clangd.setup(clangd_opts)
    end
}

-- return {}
return M
