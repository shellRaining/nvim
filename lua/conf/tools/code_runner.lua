local M = {
    requires = {
        "code_runner",
    },
    keys = {
        {
            "<leader>rf",
            function()
                vim.cmd('RunFile')
            end,
            desc = "Run the current project of file",
        },
        {
            "<leader>rc",
            function()
                vim.cmd('RunCode')
            end,
            desc = "Run the current project of file",
        },
        {
            "<F5>",
            function()
                vim.cmd('RunCode')
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
        hot_reload = false,
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
