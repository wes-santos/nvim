local function get_python_path()
    local venv_path
    venv_path = os.getenv("VIRTUAL_ENV")
    if venv_path then
        return venv_path .. "/bin/python"
    else
        if vim.loop.os_uname().sysname:find("Windows") then
            -- Implement for windows if necessary
            return ""
        else
            return "/usr/bin/python3"
        end
    end
end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap-python",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
        local python_path = get_python_path()

        -- DAP Python settings
        local dap = require("dap")
        dap.adapters.python = {
            type = "executable",
            command = (function()
                local handle = io.popen(python_path .. " -m pip show debugpy 2>/dev/null")
                if handle and not handle:read("*a"):match("Name: debugpy") then
                    vim.fn.system({ python_path, "-m", "pip", "install", "debugpy" })
                end
                return python_path
            end)(),
            args = { "-m", "debugpy.adapter" },
        }

        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                program = "${file}",
                pythonPath = python_path,
            },
        }

        -- DAP Golang settings
        dap.adapters.go = {
            type = "server",
            port = "${port}",
            executable = {
                command = "dlv",
                args = { "dap", "-l", "127.0.0.1:${port}" },
            },
        }

        dap.configurations.go = {
            {
                type = "go",
                name = "Debug",
                request = "launch",
                program = "${file}",
            },
            {
                type = "go",
                name = "Debug Package",
                request = "launch",
                program = "./",
            },
            {
                type = "go",
                name = "Attach",
                request = "attach",
                processId = require("dap.utils").pick_process,
            },
        }

        -- DAP UI setup
        local dapui = require("dapui")
        dapui.setup({
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.33 },
                        { id = "breakpoints", size = 0.17 },
                        { id = "stacks", size = 0.25 },
                        { id = "watches", size = 0.25 },
                    },
                    size = 0.33,
                    position = "right",
                },
                {
                    elements = {
                        { id = "repl", size = 1 },
                    },
                    size = 0.27,
                    position = "bottom",
                },
            },
            controls = {
                enabled = true,
                -- Display controls in this element
                element = "repl",
                icons = {
                    pause = "",
                    play = "",
                    step_into = "",
                    step_over = "",
                    step_out = "",
                    step_back = "",
                    run_last = "",
                    terminate = "",
                },
            },
            floating = {
                max_height = 0.9,
                max_width = 0.5, -- Floats will be treated as percentage of your screen.
                border = "rounded",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil, -- Can be integer or nil.
                max_value_lines = 100, -- Can be integer or nil.
            },
        })

        -- Open/close DAP UI automatically
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end

        -- Enable virtual text for debugging
        require("nvim-dap-virtual-text").setup()

        -- Telescope integration for DAP
        require("telescope").load_extension("dap")

        -- Keybindings for DAP
        vim.keymap.set("n", "<leader>ds", function() dap.continue() end, { desc = "Start/Continue Debugging" })
        vim.keymap.set("n", "<leader>dn", function() dap.step_over() end, { desc = "Step Over" })
        vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
        vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "Step Out" })
        vim.keymap.set("n", "<leader>go", function() dap.up() end, { desc = "Go out (Up) in stack trace" })
        vim.keymap.set("n", "<leader>gi", function() dap.down() end, { desc = "Go in (Down) in stack trace" })
        vim.keymap.set("n", "<leader>dv", function() dapui.variables.scopes() end, { desc = "View variables in current scope" })
        vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Set Conditional Breakpoint" })
        vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate DAP Session" })
        vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Toggle DAP UI" })
        vim.keymap.set("n", "<leader>dkb", ":Telescope dap commands<CR>", { desc = "DAP Commands" })
    end,
}
