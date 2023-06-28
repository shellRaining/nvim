-- https://github.com/microsoft/pyright

local util = require("lspconfig.util")

local root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    -- customize
    "manage.py",
    "server.py",
    "main.py",
}

return {
    filetypes = { "python" },
    single_file_support = true,
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = util.root_pattern(unpack(root_files)),
    ---@diagnostic disable-next-line: unused-local
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "LspChange", function()
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end, {
            desc = "send didChangeConfiguration to Langserver",
        })
    end,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic", -- off, basic, strict
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                diagnosticMode = "workspace",
                diagnosticSeverityOverrides = {
                    strictListInference = true,
                    strictDictionaryInference = true,
                    strictSetInference = true,
                    reportUnusedImport = "warning",
                    reportUnusedClass = "warning",
                    reportUnusedFunction = "warning",
                    reportUnusedVariable = "warning",
                    reportUnusedCoroutine = "warning",
                    reportDuplicateImport = "warning",
                    reportPrivateUsage = "warning",
                    reportUnusedExpression = "warning",
                    reportConstantRedefinition = "error",
                    reportIncompatibleMethodOverride = "error",
                    reportMissingImports = "error",
                    reportUndefinedVariable = "error",
                    reportAssertAlwaysTrue = "error",
                },
            },
        },
    },
}
