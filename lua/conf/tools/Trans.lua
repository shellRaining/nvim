-- https://github.com/JuanZoran/Trans.nvim

local M = {
    requires = {
        "Trans",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.Trans.setup({
        ---@type string the directory for database file and password file
        dir = os.getenv("HOME") .. "/.vim/dict",
        query = "fallback",
        -- backend_order = {},
        ---@type 'default' | 'dracula' | 'tokyonight' global Trans theme [see lua/Trans/style/theme.lua]
        theme = "default", -- default | tokyonight | dracula
        strategy = {
            ---@type { frontend:string, backend:string | string[] } fallback strategy for mode
            default = {
                frontend = "hover",
                backend = "*",
            },
        },
        ---@type table frontend options
        frontend = {
            ---@class TransFrontendOpts
            ---@field keymaps table<string, string>
            default = {
                ---@type boolean Whether to auto play the audio
                auto_play = true,
                border = "rounded",
                ---@type {open: string | boolean, close: string | boolean, interval: integer} Hover Window Animation
                animation = {
                    open = "slid", -- 'fold', 'slid'
                    close = "slid",
                    interval = 12,
                },
                timeout = 2000,
            },
            ---@class TransHoverOpts : TransFrontendOpts
            hover = {
                ---@type integer Max Width of Hover Window
                width = 37,
                ---@type integer Max Height of Hover Window
                height = 27,
                ---@type string -- see: /lua/Trans/style/spinner
                spinner = "dots",
                ---@type string -- TODO :support replace with {{special word}}
                fallback_message = "{{notfound}} 翻译超时或没有找到相关的翻译",
                auto_resize = true,
                padding = 10, -- padding for hover window width
                keymaps = {
                    pageup = "[[",
                    pagedown = "]]",
                    pin = "<leader>[",
                    close = "<leader>]",
                    toggle_entry = "<leader>;",
                    -- play         = '_', -- Deprecated
                },
                ---@type string[] auto close events
                auto_close_events = {
                    "InsertEnter",
                    "CursorMoved",
                    "BufLeave",
                },
                ---@type string[] order to display translate result
                order = {
                    "title",
                    "tag",
                    "pos",
                    "exchange",
                    "translation",
                    "definition",
                },
                ---@type table<string, string>
                icon = {
                    -- or use emoji
                    star = "", -- ⭐
                    notfound = " ", -- ❔
                    yes = "✔", -- ✔️
                    no = "", -- ❌
                    cell = "■", -- ■ | □ | ▇ | ▏ ▎ ▍ ▌ ▋ ▊ ▉ █
                },
            },
        },
    })
end

function M.after() end

function M.register_key() end

return M
