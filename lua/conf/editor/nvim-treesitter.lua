-- https://github.com/nvim-treesitter/nvim-treesitter

local M = {
    requires = {
        "nvim-treesitter.configs",
        "nvim-treesitter.install",
    },
}

function M.before() end

function M.load()
    M.nvim_treesitter_install.prefer_git = true
    M.nvim_treesitter_configs.setup({
        ensure_installed = {
            "bash",
            "beancount",
            "bibtex",
            "c",
            "c_sharp",
            "cairo",
            "cmake",
            "comment",
            "cpp",
            "css",
            "cuda",
            "cue",
            "dart",
            "devicetree",
            "diff",
            "dockerfile",
            "dot",
            "elm",
            "erlang",
            "fennel",
            "fish",
            "func",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "go",
            "godot_resource",
            "gomod",
            "gosum",
            "gowork",
            "groovy",
            "haskell",
            "hjson",
            "html",
            "htmldjango",
            "http",
            "hurl",
            "ini",
            "java",
            "javascript",
            "jq",
            "jsdoc",
            "json",
            "json5",
            "jsonc",
            "jsonnet",
            "julia",
            "kotlin",
            "latex",
            "llvm",
            "lua",
            "luadoc",
            "make",
            "markdown",
            "markdown_inline",
            "matlab",
            "mermaid",
            "ninja",
            "nix",
            "norg",
            "objc",
            "ocaml",
            "ocaml_interface",
            "odin",
            "org",
            "pascal",
            "passwd",
            "perl",
            "php",
            "python",
            "qmldir",
            "qmljs",
            "query",
            "regex",
            "requirements",
            "ruby",
            "rust",
            "scala",
            "scheme",
            "scss",
            "solidity",
            "sql",
            "todotxt",
            "toml",
            "tsx",
            "typescript",
            "ungrammar",
            "vim",
            "vimdoc",
            "vue",
            "wgsl",
            "yaml",
            "zig",
        },
        ignore_install = {
            "haskell",
            "latex",
            "ocaml_interface",
            "php",
            "ruby",
            "tsx",
            "tlaplus",
            "make",
            "qmldir",
        },
        highlight = {
            enable = true,
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
            -- disable = { "yaml", "python", "html", "vue", "c", "cpp" },
        },
        -- incremental selection
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<cr>",
                node_incremental = "<cr>",
                node_decremental = "<bs>",
                scope_incremental = "<tab>",
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
