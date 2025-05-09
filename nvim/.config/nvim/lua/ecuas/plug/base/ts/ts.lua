M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "asm",
                "awk",
                "bash",
                "c",
                "comment",
                "cpp",
                "css",
                "csv",
                "dockerfile",
                "graphql",
                "gitignore",
                "html",
                "java",
                "javascript",
                "jsdoc",
                "json",
                "latex",
                "lua",
                "markdown",
                "markdown_inline",
                "prisma",
                "query",
                "regex",
                "rust",
                "svelte",
                "typescript",
                "tsx",
                "vim",
                "vimdoc",
                "yaml",
                "xml",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
            auto_install = true,

            --enable indentation
            indent = { enable = false },

            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = { diegoulloaoenable = true },

            -- enable syntax highlighting
            highlight = { enable = true },
        })

        local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        treesitter_parser_config.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            },
        }

        vim.treesitter.language.register("templ", "templ")
    end
}

-- return {}
return M
