-- https://github.com/theia-ide/typescript-language-server
return {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = "/Users/shellraining/Library/pnpm/global/5/node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
            },
        },
    },
    filetypes = {
        "vue",
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
