local running = false

local function toggleRun(cmdName)
    if running then
        vim.cmd("RunClose")
    else
        vim.cmd(cmdName)
    end
    running = not running
    vim.notify(running and "Running" or "Stopped")
end
local M = {
    requires = {
        "code_runner",
    },
    keys = {
        {
            "<leader>rf",
            function()
                toggleRun("RunFile")
            end,
            desc = "Run the current project of file",
        },
        {
            "<leader>rc",
            function()
                toggleRun("RunCode")
            end,
            desc = "Run the current project of file",
        },
        {
            "<leader>rp",
            "<cmd>RunProject<CR>",
            desc = "Run the project",
        },
    },
}

function M.load()
    M.code_runner.setup({
        filetype = {
            typescript = "deno run",
            python = "python3",
        },
        focus = false,
        project = {
            ["~/Documents/learnsth/rust/guessing_name"] = {
                name = "guessing_name",
                description = "guessing_name",
                command = "cargo run",
            },
        },
    })
end

return M
