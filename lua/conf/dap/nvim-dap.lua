local api = require("utils.api")

local M = {
    requires = {
        "dap",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        -- port = "${port}",
        port = "9229",
        executable = {
            command = "node",
            args = { "/Users/shellraining/.local/share/nvim/mason/bin/js-debug-adapter", "9229" },
        },
    }

    M.dap.configurations.typescript = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            runtimeExecutable = "deno",
            runtimeArgs = {
                "run",
                "--inspect-wait",
                "--allow-all",
            },
            program = "${file}",
            cwd = "${workspaceFolder}",
            attachSimplePort = 9229,
        },
    }

    M.dap.configurations.javascript = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
    }
end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>db",
            rhs = function()
                require("dap").toggle_breakpoint()
            end,
            options = { silent = true },
            description = "Mark or delete breakpoints",
        },
        {
            mode = { "n" },
            lhs = "<leader>dc",
            rhs = function()
                require("dap").clear_breakpoints()
            end,
            options = { silent = true },
            description = "Clear breakpoints in the current buffer",
        },
        {
            mode = { "n" },
            lhs = "<F5>",
            rhs = function()
                require("dap").continue()
            end,
            options = { silent = true },
            description = "Enable debugging or jump to the next breakpoint",
        },
        {
            mode = { "n" },
            lhs = "<F6>",
            rhs = function()
                require("dap").step_into()
            end,
            options = { silent = true },
            description = "Step into",
        },
        {
            mode = { "n" },
            lhs = "<F7>",
            rhs = function()
                require("dap").step_over()
            end,
            options = { silent = true },
            description = "Step over",
        },
        {
            mode = { "n" },
            lhs = "<F8>",
            rhs = function()
                require("dap").step_out()
            end,
            options = { silent = true },
            description = "Step out",
        },
        {
            mode = { "n" },
            lhs = "<F9>",
            rhs = function()
                require("dap").run_last()
            end,
            options = { silent = true },
            description = "Rerun debug",
        },
        {
            mode = { "n" },
            lhs = "<F10>",
            rhs = function()
                require("dap").terminate()
            end,
            options = { silent = true },
            description = "Close debug",
        },
    })
end

return M
