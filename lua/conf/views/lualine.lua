---@diagnostic disable: unused-local

-- https://github.com/nvim-lualine/lualine.nvim

local M = {
    requires = {
        "lualine",
    },
}

function M.before() end

function M.load()
    M.lualine.setup({
        options = {
            -- theme = "starlight",
            icons_enabled = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {},
            globalstatus = true,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            },
            theme = "tokyonight",
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { { "filename", file_status = true, path = 1 } },
            lualine_x = { "encoding", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    })
end

function M.after() end

return M
