local M = {
    requires = {
        "typescript-tools",
    },
}

function M.load()
    M.typescript_tools.setup({
        on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
        end,

        filetypes = {
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
    })
end

return M
