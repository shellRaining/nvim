local icons = require("utils.public").get_icons_group("lsp_kind", true)

local M = {
    requires = {
        "nvim-navic",
    },
}

function M.load()
    M.nvim_navic.setup({
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = icons
    })
end

return M
