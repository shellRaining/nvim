local M = {
    requires = {
        "various-textobjs",
    },
}

function M.load()
    M.various_textobjs.setup({
        useDefaultKeymaps = true,
        disabledKeymaps = {
            "R",
            "ag",
            "ig",
            "iS",
            "aS",
            "gc",
            "iz",
            "az",
            "gW",
            "iN",
            "aN",
        },
    })
end

function M.after() end

return M
