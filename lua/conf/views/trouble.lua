local M = {
    requires = {
        "trouble",
    },
}

function M.load()
    M.trouble.setup({
        use_diagnostic_signs = true,
    })
end

M.cmd = {
    "TroubleToggle",
    "Trouble",
}

M.keys = {
    { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
}

return M
