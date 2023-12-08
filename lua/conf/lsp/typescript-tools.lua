local M = {
    requires = {
        "typescript-tools",
    },
}

function M.load()
    M.typescript_tools.setup({
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
