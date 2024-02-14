local M = {
    requires = {
        "typescript-tools",
    },
    ft = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "spec.typescript",
        "spec.javascript",
        "spec",
        "jest.typescript",
        "jest.javascript",
        "jest",
    },
}

function M.load()
    M.typescript_tools.setup({
        on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
        end,

        filetypes = M.ft,
    })
end

return M
