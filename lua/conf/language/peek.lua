local M = {
    requires = {
        "peek",
    },
}

function M.load()
    M.peek.setup()
    vim.api.nvim_create_user_command("PeekOpen", M.peek.open, {})
    vim.api.nvim_create_user_command("PeekClose", M.peek.close, {})
end

return M
