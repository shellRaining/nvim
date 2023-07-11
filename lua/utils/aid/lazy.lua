-- https://github.com/folke/lazy.nvim

---@diagnostic disable: param-type-mismatch

local api = require("utils.api")
local options = require("core.options")

local M = {
    -- plugin config file root directory
    plug_conf_root_dir = "conf",
}

function M.get_opts()
    return {
        -- plugin install root directory
        root = options.storage_directory,
        install = {
            colorscheme = { "default" },
        },
        ui = {
            border = options.float_border and "double" or "none",
        },
    }
end

function M.before()
    local lazy_install_path = api.path.join(options.storage_directory, "lazy.nvim")

    if not vim.loop.fs_stat(lazy_install_path) then
        vim.notify("Download lazy.nvim ...", "INFO", { title = "Lazy" })
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            lazy_install_path,
        })
    end

    vim.opt.runtimepath:prepend(lazy_install_path)
    M.lazy = require("lazy")
end

function M.load(plugins)
    local requires_moduls = {}
    local disabled_plugins = {
        plenary = true, -- because this is a nvim-lua lib
    }

    for plugin_kind_name, plugin_kind_tbl in pairs(plugins) do
        for _, plugin_opts in ipairs(plugin_kind_tbl) do
            local require_file_name = (plugin_opts.name or plugin_opts[1]:match("/([%w%-_]+).?")):lower()
            local require_file_path = api.path.join(M.plug_conf_root_dir, plugin_kind_name, require_file_name)
            if disabled_plugins[require_file_name] then
                goto continue
            end
            local ok, module = pcall(require, require_file_path)

            if ok then
                plugin_opts.init = plugin_opts.init
                    or function()
                        if module.before then
                            module.before()
                        end
                    end

                plugin_opts.config = plugin_opts.config
                    or function()
                        api.require_all_package(module)
                        module.load()
                        if module.after then
                            module.after()
                        end
                    end
            end
            table.insert(requires_moduls, plugin_opts)
            ::continue::
        end
    end

    M.lazy.setup(requires_moduls, M.get_opts())
end

function M.after()
    M.register_key()
end

function M.entry(plugins)
    M.before()
    M.load(plugins)
    M.after()
end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>lh",
            rhs = "<cmd>Lazy<cr>",
            options = { silent = true },
            description = "Run Lazy command",
        },
        {
            mode = { "n" },
            lhs = "<leader>li",
            rhs = "<cmd>Lazy install<cr>",
            options = { silent = true },
            description = "Run Lazy install command",
        },
        {
            mode = { "n" },
            lhs = "<leader>lu",
            rhs = "<cmd>Lazy update<cr>",
            options = { silent = true },
            description = "Run Lazy update command",
        },
        {
            mode = { "n" },
            lhs = "<leader>ls",
            rhs = "<cmd>Lazy sync<cr>",
            options = { silent = true },
            description = "Run Lazy sync command",
        },
        {
            mode = { "n" },
            lhs = "<leader>lx",
            rhs = "<cmd>Lazy clean<cr>",
            options = { silent = true },
            description = "Run Lazy clean command",
        },
        {
            mode = { "n" },
            lhs = "<leader>lc",
            rhs = "<cmd>Lazy check<cr>",
            options = { silent = true },
            description = "Run Lazy check command",
        },
        {
            mode = { "n" },
            lhs = "<leader>ll",
            rhs = "<cmd>Lazy log<cr>",
            options = { silent = true },
            description = "Run Lazy log command",
        },
        {
            mode = { "n" },
            lhs = "<leader>lr",
            rhs = "<cmd>Lazy restore<cr>",
            options = { silent = true },
            description = "Run Lazy restore command",
        },
        {
            mode = { "n" },
            lhs = "<leader>lp",
            rhs = "<cmd>Lazy profile<cr>",
            options = { silent = true },
            description = "Run Lazy profile command",
        },
        {
            mode = { "n" },
            lhs = "<leader>ld",
            rhs = "<cmd>Lazy debug<cr>",
            options = { silent = true },
            description = "Run Lazy debug command",
        },
        {
            mode = { "n" },
            lhs = "<leader>l?",
            rhs = "<cmd>Lazy help<cr>",
            options = { silent = true },
            description = "Run Lazy help command",
        },
    })
end

return M
