local api = require("utils.api")

local M = {
    requires = {
        "dap",
    },
    adapter_configurations_dir_path = api.path.join("conf", "dap", "dap_configurations"),
}

-- stylua: ignore
M.keys = {
    { "<leader>db", function() M.dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() M.dap.clear_breakpoints() end, desc = "Clear Breakpoint" },
    { "<F5>", function() M.dap.continue() end, desc = "Continue" },
    { "<F11>", function() M.dap.step_into() end, desc = "Step Into" },
    { "<F10>", function() M.dap.step_over() end, desc = "Step Over" },
    { "<F23>", function() M.dap.step_out() end, desc = "Step Out" },
    { "<F17>", function() M.dap.terminate() end, desc = "Terminate" },
    { "<F6>", function() M.dap.restart() end, desc = "Restart" },
    { "<leader>dC", function() M.dap.run_to_cursor() end, desc = "Run to Cursor" },
}

function M.load()
    local require_files_table = api.get_importable_subfiles(M.adapter_configurations_dir_path)
    for _, require_file in ipairs(require_files_table) do
        local dap_config = require(require_file)
        M.dap.adapters = vim.tbl_deep_extend("force", M.dap.adapters, dap_config.adapters or {})
        M.dap.configurations = vim.tbl_deep_extend("force", M.dap.configurations, dap_config.configurations or {})
    end
end

return M
