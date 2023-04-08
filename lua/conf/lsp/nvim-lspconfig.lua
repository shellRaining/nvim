-- https://github.com/neovim/nvim-lspconfig

local api = require("utils.api")
local aid_nvim_lsptools = require("utils.aid.nvim-lsptools")
local aid_nvim_lspconfig = require("utils.aid.nvim-lspconfig")

local M = {
    requires = {
        "neodev", -- neovim lua api complete enhance, must require
        "lspconfig",
        "mason-lspconfig",
    },
    disabled_servers = {
        "pylance",
    },
    server_configurations_dir_path = api.path.join("conf", "lsp", "server_configurations"),
}

function M.before()
    M.register_key()
end

function M.load()
    aid_nvim_lspconfig.begin()

    -- lspconfig_to_mason or mason_to_lspconfig
    local mappings = M.mason_lspconfig.get_mappings()

    -- load build-in servers and expands servers
    local servers = vim.tbl_deep_extend(
        "force",
        M.mason_lspconfig.get_installed_servers(),
        aid_nvim_lspconfig.get_expands_servers()
    )

    for _, server_name in ipairs(servers) do
        local require_path =
            api.path.join(M.server_configurations_dir_path, mappings.lspconfig_to_mason[server_name] or server_name)

        local ok, configuration = pcall(require, require_path)

        -- set default configuration
        configuration = vim.tbl_deep_extend("force", {
            ---@diagnostic disable-next-line: unused-local
            on_init = function(client, bufnr) end,
            ---@diagnostic disable-next-line: unused-local
            on_attach = function(client, bufnr) end,
        }, ok and configuration or {})

        if not vim.tbl_contains(M.disabled_servers, server_name) then
            local private_on_init = configuration.on_init
            local private_on_attach = configuration.on_attach

            configuration.capabilities = aid_nvim_lspconfig.get_capabilities()
            configuration.handlers = aid_nvim_lspconfig.get_headlers(configuration)

            configuration.on_init = function(client, bufnr)
                private_on_init(client, bufnr)
            end

            configuration.on_attach = function(client, bufnr)
                if server_name ~= "clangd" then
                    aid_nvim_lsptools.close_document_format(client)
                end
                aid_nvim_lsptools.close_semantic_tokens(client)
                aid_nvim_lsptools.did_change_configuration(client)
                -- run private_on_attach
                private_on_attach(client, bufnr)
            end

            M.lspconfig[server_name].setup(configuration)
        end
    end
end

function M.after() end

function M.register_key()
end

return M
