local M = {
    requires = {
        "lsp_signature",
    },
}

function M.load()
    M.lsp_signature.setup({
        hint_enable = false,
    })
end

return M
