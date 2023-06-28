local M = {
    requires = {
        "rust-tools",
    },
}

function M.load()
    M.rust_tools.setup({
        server = {
            on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<leader>ca", M.rust_tools.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            end,
        },
    })

    M.rust_tools.inlay_hints.enable()
end

return M
