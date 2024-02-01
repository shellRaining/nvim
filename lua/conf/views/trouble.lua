local M = {
    requires = {
        "trouble",
    },
}

function M.load()
    M.trouble.setup({
        use_diagnostic_signs = true,
        group = false,
        padding = false,
        action_keys = { -- key mappings for actions in the trouble list
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
            open_split = { "<c-x>" }, -- open buffer in new split
            open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
            open_tab = { "<c-t>" }, -- open buffer in new tab
            jump_close = { "o" }, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
            toggle_preview = "p", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = {}, -- preview the diagnostic location
            open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
            close_folds = { "zM", "zm", "zc" }, -- close all folds
            open_folds = { "zR", "zr", "zo" }, -- open all folds
            toggle_fold = { "zA", "za" }, -- toggle fold of current file
            previous = "k", -- previous item
            next = "j", -- next item
            help = "?", -- help menu
        },
    })
end

M.cmd = {
    "TroubleToggle",
    "Trouble",
}

M.keys = {
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
}

return M
