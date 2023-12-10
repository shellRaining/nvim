local api = require("utils.api")
local map = require("utils.map")
local options = require("core.options")

local M = {
    requires = {
        "luasnip",
        "luasnip.loaders.from_vscode",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.luasnip.setup({
        history = true,
        delete_check_events = "TextChanged",
    })

    M.luasnip_loaders_from_vscode.lazy_load({
        paths = {
            api.path.join(options.global_config_directory, "snippets"),
            -- api.path.join(options.storage_directory, "friendly-snippets"),
        },
    })
end

function M.after()
    -- M.luasnip.filetype_extend("javascript", { "typescript" })
    M.luasnip.filetype_extend("typescript", { "javascript" })
    -- M.luasnip.filetype_extend("jest.typescript", { "typescript" })
    -- M.luasnip.filetype_extend("jest.javascript", { "javascript" })
    -- M.luasnip.filetype_extend("vue", { "javascript", "typescript" })
end

function M.register_key()
    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>so",
            rhs = "<cmd>OpenUserSnippetFile<cr>",
            options = { noremap = true },
            description = "open snippet file for current filetype",
        },
        {
            mode = { "n" },
            lhs = "<leader>sp",
            rhs = "<cmd>OpenUserSnippetPackage<cr>",
            options = { noremap = true },
            description = "open snippet package",
        },
    })
end

M.keys = {
    {
        "<tab>",
        function()
            return M.luasnip.jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
    },
    {
        "<tab>",
        function()
            M.luasnip.jump(1)
        end,
        mode = "s",
    },
    {
        "<s-tab>",
        function()
            M.luasnip.jump(-1)
        end,
        mode = { "i", "s" },
    },
}

return M
