-- https://github.com/nvim-treesitter/nvim-treesitter

local M = {
    requires = {
        "nvim-treesitter.configs",
        "nvim-treesitter.install",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>", desc = "Decrement selection", mode = "x" },
    },
}

function M.before() end

function M.load()
    M.nvim_treesitter_install.prefer_git = true
    M.nvim_treesitter_configs.setup({
        ensure_installed = {
            "bash",
            "c",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        },
        auto_install = true,
        highlight = {
            enable = true,
            ---@diagnostic disable-next-line: unused-local
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
            disable = { "yaml", "python", "html", "c", "cpp", "lua" },
        },
        -- incremental selection
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                node_decremental = "<bs>",
                scope_incremental = false,
            },
        },
        -- nvim-ts-autotag
        autotag = {
            enable = true,
        },
        -- nvim-ts-context-commentstring
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    })
end

function M.after() end

return M
