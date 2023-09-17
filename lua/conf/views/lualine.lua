local util = require("utils.color")

local M = {
    requires = {
        "lualine",
        "nvim-navic",
        "noice",
    },
    event = "VeryLazy",
}

function M.before() end

function M.load()
    M.lualine.setup({
        options = {
            theme = "auto",
            globalstatus = true,
            disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                { "filename", file_status = true, path = 1 },
                -- stylua: ignore
                {
                    function() return M.nvim_navic.get_location() end,
                    cond = M.nvim_navic.is_available,
                },
            },
            -- stylua: ignore
            lualine_x = {
                {
                  function() return M.noice.api.status.command.get() end,
                  cond = M.noice.api.status.command.has,
                  color = util.fg("Statement"),
                },
                {
                  function() return M.noice.api.status.mode.get() end,
                  cond = M.noice.api.status.mode.has,
                  color = util.fg("Constant"),
                },
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    })
end

function M.after() end

return M
