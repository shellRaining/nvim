local M = {
    requires = {
        "live-command",
    },
}

function M.load()
    M.live_command.setup({
        commands = {
            Norm = { cmd = "norm" },
        },
    })
end

return M
