-- If you are using mason.nvim, you can get the ts_plugin_path like this
local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
    .. "/node_modules/@vue/language-server"
local util = require("lspconfig.util")
local root_files = {
    ".git",
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
}

return {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
            },
        },
    },
    root_dir = util.root_pattern(unpack(root_files)),
    filetypes = {
        "javascript",
        "typescript",
        "vue",
    },
    -- filetypes = {
    --     "vue",
    --     "javascript",
    --     "javascriptreact",
    --     "javascript.jsx",
    --     "typescript",
    --     "typescriptreact",
    --     "typescript.tsx",
    --     "spec.typescript",
    --     "spec.javascript",
    --     "spec",
    --     "jest.typescript",
    --     "jest.javascript",
    --     "jest",
    -- },
}
