-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md

---@diagnostic disable: param-type-mismatch

local options = require("core.options")

local M = {
    requires = {
        "mason",
        "mason-registry",
    },
    event = { "VimEnter" },
}

function M.before()
    M.installer_tools = {
        lsp = {
            "clangd",
            "css-lsp",
            "json-lsp",
            "html-lsp",
            "emmet-language-server",
            "vue-language-server",
            "vim-language-server",
            "lua-language-server",
            "bash-language-server",
            "typescript-language-server",
            "rust-analyzer",
            -- "markdownlint",
            -- "unocss-language-server",
            -- "tailwindcss-language-server",
        },
        dap = {},
        linter = {
            "pylint",
        },
        formatter = {
            "shfmt",
            -- "autopep8",
            "clang-format",
            "prettier",
            -- "eslint-lsp",
        },
    }
end

function M.load()
    M.mason.setup({
        max_concurrent_installers = 20,
        ui = {
            border = options.float_border and "double" or "none",
        },
        install_root_dir = options.mason_install_directory,
    })
end

function M.after()
    local installed_packages = {}

    for _, package_kind in pairs(M.installer_tools) do
        for _, package_name_version in pairs(package_kind) do
            ---@diagnostic disable-next-line: missing-parameter
            local name, version = unpack(vim.split(package_name_version, "@"))

            if not M.mason_registry.is_installed(name) then
                if not M.mason_registry.has_package(name) then
                    vim.notify(("Invalid package name : %s"):format(name), "ERROR", { title = "Mason" })
                else
                    local params = version and { version = version }
                    M.mason_registry.get_package(name):install(params)
                    table.insert(installed_packages, package_name_version)
                end
            end
        end
    end

    if not vim.tbl_isempty(installed_packages) then
        vim.notify(
            ("Start install package : \n - %s"):format(table.concat(installed_packages, "\n - ")),
            "INFO",
            { title = "Mason" }
        )
    end
end

return M
