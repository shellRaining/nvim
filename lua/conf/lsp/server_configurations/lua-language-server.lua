-- https://github.com/sumneko/lua-language-server

local util = require("lspconfig.util")

local runtime_path = vim.split(package.path, ";")

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local root_files = {
    ".luarc.json",
    ".luacheckrc",
    ".stylua.toml",
    "selene.toml",
    -- custom settings
    ".git",
}

local path = {
    "/Users/shellraining/.config/nvim",
    "/Users/shellraining/.local/share/nvim/store/neodev.nvim",
    "/Users/shellraining/.local/share/nvim/store/hlchunk.nvim",
}

return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    single_file_support = true,
    root_dir = function(fname)
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
    log_level = 2,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = path,
                checkThirdParty = true,
            },
        },
    },
}
