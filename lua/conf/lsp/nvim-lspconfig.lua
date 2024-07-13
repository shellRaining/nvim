-- https://github.com/neovim/nvim-lspconfig

local join = require("utils.api").path.join
local options = require("core.options")
local map = require("utils.map")

local M = {
    requires = {
        "lspconfig",
        "mason-lspconfig",
        -- "telescope.builtin",
        "cmp_nvim_lsp",
        "lazydev",
    },
    server_config_path = join("conf", "lsp", "server_configurations"),
}

function M.load()
    require("lspconfig.ui.windows").default_options.border = options.float_border and "double" or "none"
    -- neodev should init before luals
    M.lazydev.setup({})

    local mappings = M.mason_lspconfig.get_mappings()
    local not_fmt_lang = {
        clangd = true,
        tsserver = true,
        jsonls = true,
        html = true,
        volar = true,
        lua_ls = true,
        cssls = true,
    }
    local servers = M.mason_lspconfig.get_installed_servers()

    for _, server_name in ipairs(servers) do
        local require_path = join(M.server_config_path, mappings.lspconfig_to_mason[server_name] or server_name)
        local ok, configuration = pcall(require, require_path)
        if not ok then
            configuration = {}
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
            client.server_capabilities.semanticTokensProvider = nil
            private_on_attach(client, bufnr)
        end
        -- NOTE: without this require, the jsonls schema will not work
        configuration.capabilities = M.cmp_nvim_lsp.default_capabilities()

        M.lspconfig[server_name].setup(configuration)
    end
end

local cmd_groups = {
    definitions = {
        native = vim.lsp.buf.definition,
        telescope = "<cmd>Telescope lsp_definitions<cr>",
        trouble = "<cmd>Trouble lsp_definitions<cr>",
        fzf = "<cmd>FzfLua lsp_definitions<cr>",
    },
    implementations = {
        native = vim.lsp.buf.implementation,
        telescope = "<cmd>Telescope lsp_implementations<cr>",
        trouble = "<cmd>Trouble lsp_implementations<cr>",
        fzf = "<cmd>FzfLua lsp_implementations<cr>",
    },
    references = {
        native = vim.lsp.buf.references,
        telescope = "<cmd>Telescope lsp_references<cr>",
        trouble = "<cmd>Trouble lsp_references<cr>",
        fzf = "<cmd>FzfLua lsp_references<cr>",
    },
    type_definitions = {
        native = vim.lsp.buf.type_definition,
        telescope = "<cmd>Telescope lsp_type_definitions<cr>",
        trouble = "<cmd>Trouble lsp_type_definitions<cr>",
        fzf = "<cmd>FzfLua lsp_typedefs<cr>",
    },
    code_actions = {
        native = vim.lsp.buf.code_action,
        telescope = "<cmd>Telescope lsp_code_actions<cr>",
        trouble = vim.lsp.buf.code_action, -- not have this cmd
        fzf = "<cmd>FzfLua lsp_code_actions<cr>",
    },
}

function M.after()
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
        title = "hover",
    })
    local type = "fzf"
    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>ca",
            rhs = cmd_groups.code_actions[type],
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
            lhs = "K",
            rhs = vim.lsp.buf.hover,
            options = { silent = true },
            description = "check doc",
        },
        {
            mode = { "n" },
            lhs = "gd",
            rhs = cmd_groups.definitions[type],
            options = { silent = true },
            description = "peek to definitions",
        },
        {
            mode = { "n" },
            lhs = "gi",
            rhs = cmd_groups.implementations[type],
            options = { silent = true },
            description = "Show help information",
        },
        {
            mode = { "n" },
            lhs = "gr",
            rhs = cmd_groups.references[type],
            options = { silent = true },
            description = "peek to references",
        },
        {
            mode = { "n" },
            lhs = "gt",
            rhs = cmd_groups.type_definitions[type],
            options = { silent = true },
            description = "peek to type define of a variable",
        },
        {
            mode = { "n" },
            lhs = "<F8>",
            rhs = function()
                vim.diagnostic.goto_next({
                    float = false,
                })
            end,
            options = { silent = true },
            description = "goto next diagnostic",
        },
        {
            mode = { "n" },
            lhs = "<S-F8>",
            rhs = function()
                vim.diagnostic.goto_prev({
                    float = false,
                })
            end,
            options = { silent = true },
            description = "goto previous diagnostic",
        },
    })
end

return M
