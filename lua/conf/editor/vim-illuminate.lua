-- https://github.com/RRethy/vim-illuminate

local M = {
    requires = {
        "illuminate",
    },
    event = { "BufReadPost", "BufNewFile" },
}

function M.before() end

function M.load()
    M.illuminate.configure({
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
            providers = { "lsp" },
        },
        filetypes_denylist = {
            "NvimTree",
            "aerial",
            "undotree",
            "dbui",
            "spectre_panel",
            "help",
            "lazy",
            "mason",
            "notify",
            "lspinfo",
            "TelescopePrompt",
        },
    })
end

function M.after() end

return M
