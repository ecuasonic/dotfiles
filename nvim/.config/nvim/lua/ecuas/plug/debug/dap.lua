return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- languages
        "jbyuki/one-small-step-for-vimkind",

        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
        require('dapui').setup()
        local dap = require('dap')

        -- c, c++, rust
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = {
                "--interpreter=dap",
                "--eval-command",
                "set print pretty on"
            }
        }
        dap.configurations.c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = "Select and attach to process",
                type = "gdb",
                request = "attach",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                pid = function()
                    local name = vim.fn.input('Executable name (filter): ')
                    return require("dap.utils").pick_process({ filter = name })
                end,
                cwd = '${workspaceFolder}'
            },
            {
                name = 'Attach to gdbserver :1234',
                type = 'gdb',
                request = 'attach',
                target = 'localhost:1234',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}'
            },
        }
        dap.configurations.cpp = dap.configurations.c
        dap.configurations.rust = dap.configurations.c

        -- lua
        dap.configurations.lua = {
            {
                type = 'nlua',
                request = 'attach',
                name = "nlua attach",
                host = '127.0.0.1',
                port = function()
                    local val = tonumber(vim.fn.input('Port: '))
                    return val
                end,
            }
        }
        dap.adapters.nlua = function(callback, config)
            callback({
                type = 'server',
                host = config.host,
                port = config.port or 5005
            })
        end

        -- bash
        dap.configurations.sh = {
            {
                type = 'bashdb',
                request = 'launch',
                name = "Launch file",
                showDebugOutput = true,
                pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
                pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
                trace = true,
                file = "${file}",
                program = "${file}",
                cwd = '${workspaceFolder}',
                pathCat = "cat",
                pathBash = "/bin/bash",
                pathMkfifo = "mkfifo",
                pathPkill = "pkill",
                args = {},
                argsString = '',
                env = {},
                terminalKind = "integrated",
            }
        }
        dap.adapters.bashdb = {
            type = "executable";
            command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter";
            name = "bashdb";
        }

        vim.keymap.set("n", "<c-d>", function()
            require("dapui").toggle()
        end, {desc = "dapui toggle"})

        vim.keymap.set("n", "<F1>", function()
            require("dap").continue()
        end, {desc = "dap continue"})

        vim.keymap.set("n", "<F2>", function()
            require("dap").step_over()
        end, {desc = "dap step_over"})

        vim.keymap.set("n", "<F3>", function()
            require("dap").step_into()
        end, {desc = "dap step_into"})

        vim.keymap.set("n", "<F4>", function()
            require("dap").step_out()
        end, {desc = "dap step_out"})

        vim.keymap.set("n", "<leader>b", function()
            require("dap").toggle_breakpoint()
        end, {desc = "dap toggle breakpoint"})
    end
}
