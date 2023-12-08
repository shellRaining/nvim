-- https://github.com/neovim/nvim-lspconfig

local join = require("utils.api").path.join
local options = require("core.options")
local map = require("utils.map")

local M = {
    requires = {
        "neodev", -- neovim lua api complete enhance, must require
        "lspconfig",
        "mason-lspconfig",
        "telescope.builtin",
        "cmp_nvim_lsp",
    },
    server_config_path = join("conf", "lsp", "server_configurations"),
}

function M.load()
    require("lspconfig.ui.windows").default_options.border = options.float_border and "double" or "none"

    local mappings = M.mason_lspconfig.get_mappings()
    local ignore_lang = {
        tsserver = true,
    }
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
        if ignore_lang[server_name] then
            goto continue
        end
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
            private_on_attach(client, bufnr)
        end
        -- NOTE: without this require, the jsonls schema will not work
        configuration.capabilities = M.cmp_nvim_lsp.default_capabilities()

        M.lspconfig[server_name].setup(configuration)
        ::continue::
    end
end

function M.after()
    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>ca",
            rhs = vim.lsp.buf.code_action,
            options = { silent = true },
            description = "Show code action",
        },
        {
            mode = { "n" },
            lhs = "<leader>cn",
            rhs = vim.lsp.buf.rename,
            options = { silent = true },
            description = "Variable renaming",
        },
        {
            mode = { "n" },
            lhs = "<leader>cf",
            rhs = function()
                vim.lsp.buf.format({ async = true })
            end,
            options = { silent = true },
            description = "Format buffer",
        },
        {
            mode = { "n" },
            lhs = "gi",
            rhs = function()
                M.telescope_builtin.lsp_implementations({ reuse_win = true })
            end,
            options = { silent = true },
            description = "Show help information",
        },
        {
            mode = { "n" },
            lhs = "K",
            rhs = vim.lsp.buf.hover,
            options = { silent = true },
            description = "check doc",
        },
        {
            mode = { "n" },
            lhs = "gd",
            rhs = function()
                M.telescope_builtin.lsp_definitions({ reuse_win = true })
            end,
            options = { silent = true },
            description = "peek to definitions",
        },
        {
            mode = { "n" },
            lhs = "gr",
            rhs = function()
                M.telescope_builtin.lsp_references({ reuse_win = true })
            end,
            options = { silent = true },
            description = "peek to references",
        },
        {
            mode = { "n" },
            lhs = "gt",
            rhs = function()
                M.telescope_builtin.lsp_type_definitions({ reuse_win = true })
            end,
            options = { silent = true },
            description = "peek to type define of a variable",
        },
    })
end

return M
