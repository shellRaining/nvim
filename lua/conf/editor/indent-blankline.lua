-- https://github.com/lukas-reineke/indent-blankline.nvim

local M = {
    requires = {
        "ibl",
        -- "indent-rainbowline",
    },
}

function M.load()
    M.ibl.setup()
    -- M.ibl.setup(M.indent_rainbowline.make_opts({}, {
    --     color_transparency = 0.15,
    --     colors = { 0xffff40, 0x79ff79, 0xff79ff, 0x4fecec, },
    -- }))
end

function M.after() end

return M
