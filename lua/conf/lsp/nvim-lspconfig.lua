-- https://github.com/neovim/nvim-lspconfig

local join = require("utils.api").path.join
local options = require("core.options")

local M = {
    requires = {
        "neodev", -- neovim lua api complete enhance, must require
        "lspconfig",
        "mason-lspconfig",
        "nvim-navic",
    },
    server_config_path = join("conf", "lsp", "server_configurations"),
}

function M.load()
    vim.g.navic_silence = true
    require("lspconfig.ui.windows").default_options.border = options.float_border and "double" or "none"

    local mappings = M.mason_lspconfig.get_mappings()
    local not_fmt_lang = {
        clangd = true,
        tsserver = true,
        jsonls = true,
        html = true,
        volar = true,
        lua_ls = true,
    }
    local servers = M.mason_lspconfig.get_installed_servers()

    for _, server_name in ipairs(servers) do
        local require_path = join(M.server_config_path, mappings.lspconfig_to_mason[server_name] or server_name)
        local ok, configuration = pcall(require, require_path)
        if not ok then
            goto continue
        end

        local private_on_init = configuration.on_init or function() end
        local private_on_attach = configuration.on_attach or function() end

        configuration.on_init = function(client, bufnr)
            private_on_init(client, bufnr)
        end
        configuration.on_attach = function(client, bufnr)
            if not_fmt_lang[server_name] then
                client.server_capabilities.documentFormattingProvider = false
            end
            if client.server_capabilities.documentSymbolProvider then
                M.nvim_navic.attach(client, bufnr)
            end
            private_on_attach(client, bufnr)
        end

        M.lspconfig[server_name].setup(configuration)
        ::continue::
    end
end

return M
