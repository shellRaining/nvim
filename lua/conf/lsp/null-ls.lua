-- https://github.com/jose-elias-alvarez/null-ls.nvim
local options = require("core.options")

local M = {
    requires = {
        "null-ls",
    },
    formatting_filetype_extends = {
        shfmt = { "zsh" },
    },
    event = { "BufReadPre", "BufNewFile" },
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
            -- linter
            M.null_ls.builtins.diagnostics.markdownlint,
            -- M.null_ls.builtins.diagnostics.vale,
            -- M.null_ls.builtins.diagnostics.textlint,

            -- formatters
            -- M.null_ls.builtins.formatting.autopep8,
            M.null_ls.builtins.formatting.black,
            -- M.null_ls.builtins.formatting.eslint,
            M.null_ls.builtins.formatting.shfmt,
            M.null_ls.builtins.formatting.clang_format,
            M.null_ls.builtins.formatting.stylua,
            M.null_ls.builtins.formatting.prettier.with({
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                    "css",
                    "scss",
                    "less",
                    "html",
                    "yaml",
                    "graphql",
                    "handlebars",
                    "json",
                    "json5",
                    "jsonc",
                    "wxss",
                    "wxml",
                    "markdown",
                },
            }),
            M.null_ls.builtins.formatting.google_java_format,
            -- M.null_ls.builtins.formatting.mdformat,
            M.null_ls.builtins.formatting.bean_format,
            -- M.null_ls.builtins.diagnostics.stylelint.with({
            --     filetypes = {
            --         "css",
            --         "scss",
            --         "less",
            --         "vue",
            --     },
            -- }),
            -- M.null_ls.builtins.formatting.markdown_toc,
        },
    })
end

function M.after() end

return M
