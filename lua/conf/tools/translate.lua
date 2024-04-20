local M = {
    requires = {
        "translate",
    },
}

M.keys = {
    {
        "<c-t>",
        "<cmd>Translate ZH -source=EN<cr><esc>",
        silent = true,
        mode = "v",
        desc = "Translate selection",
    },
    {
        "<leader>tw",
        "viw<cmd>Translate ZH<cr><esc>",
        silent = true,
        mode = "n",
        desc = "Translate word",
    },
}

function M.load()
    M.translate.setup({
        default = {
            command = "translate_shell",
        },
        preset = {
            output = {
                split = {
                    append = true,
                },
            },
        },
    })
end

return M
