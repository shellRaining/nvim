local api = require("utils.api")
local options = require("core.options")

local M = {
    requires = {
        "luasnip",
        "luasnip.loaders.from_vscode",
    },
}

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
    {
        "<leader>so",
        "<cmd>OpenUserSnippetFile<cr>",
        mode = "n",
        desc = "open snippet file for current filetype",
    },
    {
        "<leader>sp",
        "<cmd>OpenUserSnippetPackage<cr>",
        mode = "n",
        desc = "open snippet package",
    },
}


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
    -- M.luasnip.filetype_extend("javascript", { "typescript" })
    -- M.luasnip.filetype_extend("typescript", { "javascript" })
    -- M.luasnip.filetype_extend("jest.typescript", { "typescript" })
    -- M.luasnip.filetype_extend("jest.javascript", { "javascript" })
    -- M.luasnip.filetype_extend("vue", { "javascript", "typescript" })
end

return M
