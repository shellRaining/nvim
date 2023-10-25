-- https://github.com/folke/which-key.nvim

local M = {
    requires = {
        "which-key",
    },
    event = { "VeryLazy" },
}

function M.before() end

function M.load()
    M.which_key.setup({
        plugins = {
            spelling = {
                enabled = true,
                suggestions = 20,
            },
        },
    })
end

function M.after()
    -- global leader
    M.which_key.register({
        b = { name = "Buffers" },
        c = { name = "Code" },
        f = { name = "Find" },
        g = { name = "Git" },
        l = { name = "Lazy" },
        r = { name = "Run Code" },
        s = { name = "Session" },
        u = { name = "UI" },
        t = { name = "Terminal" },
        n = { name = "Noice" },
        x = { name = "trouble" },
    }, { prefix = "<leader>", mode = "n" })

    -- comment
    M.which_key.register({
        c = {
            name = "Comment",
            c = "Toggle line comment",
            b = "Toggle block comment",
            a = "Insert line comment to line end",
            j = "Insert line comment to next line",
            k = "Insert line comment to previous line",
        },
    }, { prefix = "g", mode = "n" })

    M.which_key.register({
        c = "Switch the specified line to a line comment",
        b = "Switch the specified line to a block comment",
    }, { prefix = "g", mode = "v" })
end

return M
