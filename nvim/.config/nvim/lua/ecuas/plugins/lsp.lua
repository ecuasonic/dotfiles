return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",

        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind-nvim",
        "windwp/nvim-autopairs"
    },

    config = function()
        -- Setup nvim-autopairs
        local status_ok, npairs = pcall(require, "nvim-autopairs")
        if not status_ok then
            return
        end

        npairs.setup {
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
                java = false,
            },
            disable_filetype = { "TelescopePrompt", "spectre_panel" },
        }

        -- cmp
        local cmp = require('cmp')
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "arduino_language_server"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup({
                        -- capabilities = capabilities,
                        init_options = {
                            completion = {
                                placeholder = false,
                            },
                        },
                        cmd = {
                            'clangd',
                            '--background-index',
                            '--clang-tidy',
                            '--log=verbose'
                        },
                        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                        single_file_support = false,
                        root_dir = lspconfig.util.root_pattern(
                            '.clangd',
                            '.clang-tidy',
                            '.clang-format',
                            'compile_commands.json',
                            'compile_flags.txt',
                            'configure.ac',
                            '.git'
                        )
                        -- root_dir = function(fname)
                        --     local filename = util.path.is_absolute(fname) and fname
                        --     or util.path.join(vim.loop.cwd(), fname)
                        --     return root_pattern(filename) or util.path.dirname(filename)
                        -- end;
                    })
                end
            }
        })

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-j>'] = cmp.mapping.scroll_docs(-4),
                ['<C-k>'] = cmp.mapping.scroll_docs(4),
                ['<C-a>'] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
            }),
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'vim_lsp' },
                },
                {
                    { name = "path" },
                    { name = 'buffer', keyword_length = 4 },
                }),
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = lspkind.cmp_format({
                    mode = "symbol",
                    with_text = true,
                    menu = {
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[NVLUA]",
                        luasnip = "[SNIP]",
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
                else
                    return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                end
            end
        })

        -- -- '/' cmdline setup
        -- cmp.setup.cmdline({ "/", "?" }, {
        --     mapping = cmp.mapping.preset.cmdline(),
        --     sources = {
        --         { name = "buffer" },
        --     }
        -- })
        --
        -- -- ':' cmdline setup
        -- cmp.setup.cmdline(":",{
        --     mapping = cmp.mapping.preset.cmdline(),
        --     sources = cmp.config.sources({
        --         { name = "path" },
        --     }, {
        --         { name = "cmdline" },
        --     }),
        -- })
        --
        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    end
}
