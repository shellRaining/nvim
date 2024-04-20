local M = {
    requires = {
        "dap",
        "dapui",
    },
}

-- stylua: ignore
M.keys = {
    { "<leader>du", function() M.dapui.toggle({}) end, desc = "Dap UI", },
    { "<leader>de", function() M.dapui.eval() end, desc = "Eval", mode = { "n", "v" }, },
}

function M.load()
    M.dapui.setup()
    -- Automatically start dapui when debugging starts
    M.dap.listeners.after.event_initialized["dapui_config"] = function()
        M.dapui.open()
    end
    -- Automatically close dapui and repl windows when debugging is closed
    M.dap.listeners.before.event_terminated["dapui_config"] = function()
        M.dapui.close()
        M.dap.repl.close()
    end
    -- Automatically close dapui and repl windows when debugging is closed
    M.dap.listeners.before.event_exited["dapui_config"] = function()
        M.dapui.close()
        M.dap.repl.close()
    end
end

return M
