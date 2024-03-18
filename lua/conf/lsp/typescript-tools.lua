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
        "vue",
    },
}

function M.load()
    M.typescript_tools.setup({
        on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
        end,
        settings = {
            tsserver_plugins = {
                "@vue/typescript-plugin",
            },
        },

        filetypes = M.ft,
    })
end

return M
