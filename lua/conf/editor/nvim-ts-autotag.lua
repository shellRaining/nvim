local M = {
    requires = {
        "nvim-ts-autotag",
    },
    event = "VeryLazy",
}

function M.load()
    M.nvim_ts_autotag.setup({
        opts = {
            enable_close = true, -- Auto close tags
            enable_rename = true, -- Auto rename pairs of tags
            enable_close_on_slash = true, -- Auto close on trailing </
        },
    })
end

return M
