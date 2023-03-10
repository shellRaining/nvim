-- https://github.com/folke/lazy.nvim

local aid_lazy = require("utils.aid.lazy")

local M = {}

M.theme = {
    { "folke/tokyonight.nvim" },
}

M.basic = {
    {
        "rcarriga/nvim-notify",
        priority = 90,
    },
    {
        "williamboman/mason.nvim",
        event = { "VimEnter" },
    },
    {
        "nvim-tree/nvim-web-devicons",
        event = { "VimEnter" },
    },
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
}

M.lsp = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
        },
    },
    -- in nvim-lspconfig config file require neodev
    {
        "folke/neodev.nvim",
        lazy = true,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "UIEnter" },
    },
    {
        "j-hui/fidget.nvim",
        event = { "LspAttach" },
    },
    { "glepnir/lspsaga.nvim" },
}

M.complete = {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "saadparwaiz1/cmp_luasnip" },
            { "tzachar/cmp-tabnine", build = "./install.sh" },
        },
        event = { "InsertEnter", "CmdlineEnter" },
    },
    {
        "L3MON4D3/LuaSnip",
        -- in nvim-cmp config file require luasnip
        lazy = true,
    },
}

M.editor = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            { "windwp/nvim-ts-autotag" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            { "nvim-lua/plenary.nvim" },
        },
        event = { "UIEnter" },
    },
    {
        "RRethy/vim-illuminate",
        event = { "UIEnter" },
    },
    {
        "shellRaining/hlchunk.nvim",
        event = { "UIEnter" },
    },
    -- {
    -- 	"lukas-reineke/indent-blankline.nvim",
    -- 	event = { "UIEnter" },
    -- },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
        event = { "VeryLazy" },
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        event = { "VeryLazy" },
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
    },
}

M.find = {
    {
        "kevinhwang91/nvim-hlslens",
        event = { "CmdlineEnter" },
        lazy = true,
    },
    {
        "folke/todo-comments.nvim",
        event = { "UIEnter" },
    },
    {
        "phaazon/hop.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
    },
}

M.language = {
    {
        "davidgranstrom/nvim-markdown-preview",
        ft = { "markdown" },
    },
}

M.tools = {
    {
        "NvChad/nvim-colorizer.lua",
        event = { "UIEnter" },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "UIEnter" },
    },
    {
        "uga-rosa/translate.nvim",
        event = { "VeryLazy" },
    },
    {
        "olimorris/persisted.nvim",
        event = { "VeryLazy" },
    },
    {
        "folke/which-key.nvim",
        event = { "VeryLazy" },
    },
    {
        "askfiy/nvim-picgo",
        lazy = true,
    },
    {
        "kristijanhusak/vim-carbon-now-sh",
        cmd = { "CarbonNowSh" },
    },
}

M.views = {
    { "glepnir/dashboard-nvim" },
    {
        "akinsho/bufferline.nvim",
        event = { "UIEnter" },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "UIEnter" },
    },
    {
        "mbbill/undotree",
        event = { "UIEnter" },
    },
    {
        "stevearc/aerial.nvim",
        event = { "UIEnter" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = true,
    },
    {
        "akinsho/toggleterm.nvim",
        lazy = true,
    },
}

aid_lazy.entry(M)

return M
