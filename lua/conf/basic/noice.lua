-- https://github.com/rcarriga/nvim-notify

local api = require("utils.api")

local M = {
    requires = {
        "noice",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.noice.setup({
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            progress = {
                enabled = true,
                format = "lsp_progress",
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- frequency to update lsp progress message
                view = "mini",
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        popupmenu = {
            backend = "cmp", -- backend to use to show regular cmdline completions
            kind_icons = {}, -- set to `false` to disable icons
        },
        presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
            command_palette = {
                views = {
                    cmdline_popup = {
                        position = {
                            row = "50%",
                            col = "50%",
                        },
                        size = {
                            min_width = 60,
                            width = "auto",
                            height = "auto",
                        },
                    },
                },
            },
        },
        views = {
            mini = {
                win_options = {
                    winblend = 0,
                },
            },
        },
        format = {
            spinner = {
                -- name = "arc",
                -- name = "arrow",
                name = "dots",
                -- name = 'mindblown',
                -- name = 'moon',
                -- name = "soccerHeader",
                -- name = 'weather',
            },
        },
    })
end

function M.after() end

function M.register_key()
    -- api.map.bulk_register({
    --     {
    --         mode = { "c" },
    --         lhs = "<S-Enter>",
    --         rhs = function()
    --             require("noice").redirect(vim.fn.getcmdline())
    --         end,
    --         options = { silent = true },
    --         description = "redirect cmdline",
    --     },
    -- })
end

return M
