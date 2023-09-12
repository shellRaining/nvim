-- https://github.com/jose-elias-alvarez/null-ls.nvim
local options = require("core.options")

local M = {
    requires = {
        "null-ls",
    },
    formatting_filetype_extends = {
        shfmt = { "zsh" },
        fixjson = { "json5" },
    },
}

function M.before() end

function M.load()
    for package_name, filetype_tables in pairs(M.formatting_filetype_extends) do
        vim.tbl_map(function(filetype)
            table.insert(M.null_ls.builtins.formatting[package_name].filetypes, filetype)
        end, filetype_tables)
    end

    -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    M.null_ls.setup({
        border = options.float_border and "double" or "none",
        -- on_attach = function(client, bufnr)
        --     if client.supports_method("textDocument/formatting") then
        --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        --         vim.api.nvim_create_autocmd("InsertLeave", {
        --             group = augroup,
        --             buffer = bufnr,
        --             callback = function()
        --                 -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        --                 -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
        --                 -- vim.lsp.buf.formatting_sync()
        --                 vim.lsp.buf.format({ async = false })
        --             end,
        --         })
        --     end
        -- end,
        sources = {
            -- M.null_ls.builtins.diagnostics.pylint.with({
            --     extra_args = {
            --         "-f",
            --         "json",
            --         "--load-plugins=pylint_django",
            --         "--disable=django-not-configured",
            --         "--rcfile=" .. api.path.join(options.lint_directory, "pylint.conf"),
            --     },
            -- }),

            -- linter
            M.null_ls.builtins.diagnostics.luacheck,
            M.null_ls.builtins.diagnostics.jsonlint,

            -- formatters
            M.null_ls.builtins.formatting.autopep8,
            -- M.null_ls.builtins.formatting.eslint,
            M.null_ls.builtins.formatting.shfmt,
            M.null_ls.builtins.formatting.clang_format,
            M.null_ls.builtins.formatting.stylua,
            M.null_ls.builtins.formatting.prettier,
            M.null_ls.builtins.formatting.google_java_format,
            M.null_ls.builtins.formatting.xmlformat,
            M.null_ls.builtins.formatting.rustfmt,
        },
    })
end

function M.after() end

return M
